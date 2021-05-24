% 각각의 cluster와 요소값(intensity)의 거리 계산 함수
function d = distance_nar(x,means)
    d = abs(x-means); 
end