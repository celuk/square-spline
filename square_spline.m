% Square Spline
% Seyyid Hikmet CELIK
% 07/03/2021

% Fonksiyonu kullanirken bir x ve bir y vektorunu parametre olarak vermelisiniz.
% Ornegin, x = [1 2 3 4 5] , y = [1 2 0 1 3] iken
% square_spline(x, y) seklinde kullanabilirsiniz.
% Bu fonksiyon daha guzel gozuksun diye katsayilar matrisini tablo seklinde
% donuyor, eger matris olarak istenirse asagida daha detayli sekilde acikladim.

function denklemkatsayilarimatrisi = square_spline(xmatrisi, ymatrisi)

% Once x vektorundeki degerleri siraliyorum ve bu değerlere onceden karsilik
% gelen y vektorundeki degerleri de karistirmamak icin x' e gore siraliyorum
% cunku cizdirecegim grafik icin x degerleri ornegin [2 3 1 4 6] gibi sirasiz 
% bir sekilde verilmisse bu degerlerin [1 2 3 4 6] sirasinda olmasi gerekir ki
% grafigi hata vermeden cizdirebileyim, diger turlu ornegin x degeri 3' ten 1' e
% gecerken grafigi geriye dogru cizdiremem ve hata verir.
% Eger x ve y vektorleri, x degerleri icin artan sirada verilecekse bu kod parcasi yoruma alinabilir.

[xmatrisi, indissirasi] = sort(xmatrisi);
ymatrisi = ymatrisi(indissirasi);

a = zeros(1, numel(xmatrisi)-1);
b = zeros(1, numel(xmatrisi)-1);
c = zeros(1, numel(xmatrisi)-1);

b(1) = 0;

% Eger farkli x, y vektorleri icin farkli spline grafikleri ayni pencerede
% ust uste binmis sekilde cizdirilmek isteniyorsa figure; kodu yoruma alinmali.
figure;

% Yazdigim denklemlere gore for dongusu ceviriyorum ve fonksiyonlari kendi
% araliklarinda, parca parca grafik olarak cizdiriyorum ve farkli renklerde
% parcali fonksiyonlar butun bir grafik haline geliyor.

for i = 1 : numel(xmatrisi) - 1
    
    a(i) = ymatrisi(i);
    c(i) = ( ymatrisi(i+1) - ymatrisi(i) - b(i) .* (xmatrisi(i+1)-xmatrisi(i)) ) ./ ( (xmatrisi(i+1)-xmatrisi(i))^(2) );
    
    if i < numel(xmatrisi) -1
        b(i+1) = b(i) + 2 .* c(i) .* (xmatrisi(i+1)-xmatrisi(i));
    end
    
    fonksiyon = @(x) ( a(i) + b(i) .* (x-xmatrisi(i)) + c(i) .* ( (x-xmatrisi(i)).^(2) ) ) .* ( (x <= xmatrisi(i+1)) & (x >= xmatrisi(i)) ) ;
    hold on;
    fplot(fonksiyon, [xmatrisi(i) xmatrisi(i+1)]);
    
end

hold off;

kacincidenkleminkatsayilari = cellstr(string(1:1:numel(xmatrisi)-1) + ". denk.");

denklemkatsayilarimatrisi = [a; b; c];
denklemkatsayilarimatrisi = array2table(denklemkatsayilarimatrisi,'RowNames', {'Sabit Terim Katsayıları (a)', 'xli Terim Katsayıları (b)', 'xkareli Terim Katsayıları (c)'},'VariableNames',kacincidenkleminkatsayilari);

% Burada denklemlerdeki a, b, c katsayilari matrisini daha guzel gozuksun diye 
% isimlendirdigim bir tabloya cevirdim ve fonksiyon calistirildiginda tablo donuyor.
% Denklem sirasina göre, ilk satir a, ikinci satir b ve ucuncu satir c katsayilarini iceriyor.
% Eger donen matris daha sonra kullanilacaksa veya sadece matris dönülmesi isteniyorsa 
% son kod satiri yoruma alinabilir ya da donulen tablodan table2array
% fonksiyonuyla tablo tekrar matrise cevirilebilir.
% Ornegin, table2array(odev2_181201047(xmatrisi,ymatrisi)) seklinde.

end

%% Kullanilan kaynaklar :

% https://www.mathworks.com/support.html
% https://en.wikipedia.org/wiki/Spline_(mathematics)
