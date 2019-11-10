function newMagnitudeImage = NonMaximalSuppression(magnitude,orientation)

% Write your function here
[YY, XX] = size(magnitude);

newMagnitudeImage = zeros(YY, XX);
tmp = newMagnitudeImage;

% The comparison for horizontal to find horizontal edges
horMag = ( (orientation>(-pi/8)) & (orientation<=(pi/8)) ) | ...
         ( (orientation>(7*pi/8)) | (orientation<=(-7*pi/8)) );
tmp(:,2:XX) = magnitude(:,1:XX-1); %shifted in x direction
comp1 = horMag & ( (magnitude - tmp)>0 ); % Comparison to left-side
tmp(:,1:XX-1) = magnitude(:,2:XX);  %shifted in x direcrtion
comp2 = horMag & ( (magnitude - tmp)>0 ); % Comparison to right-side
newMagnitudeImage = newMagnitudeImage + magnitude .* ( comp1 & comp2 );

% figure(4), imshow(newMagnitudeImage/max(newMagnitudeImage(:)))

% The comparison for vertical to find vertical edges
vertMag = ( (orientation>(3*pi/8)) & (orientation<=(5*pi/8)) ) | ... 
           ( (orientation>(-5*pi/8)) & (orientation<=(-3*pi/8)) );
tmp(2:YY,:) = magnitude(1:YY-1,:); %shifted in y direction
comp1 = vertMag & ( (magnitude - tmp)>0 ); % Comparison to up-side
tmp(1:YY-1,:) = magnitude(2:YY,:);  %shifted in y direcrtion
comp2 = vertMag & ( (magnitude - tmp)>0 ); % Comparison to down-side
newMagnitudeImage = newMagnitudeImage + magnitude .* ( comp1 & comp2 );

% figure(5), imshow(newMagnitudeImage/max(newMagnitudeImage(:)))


% The comparison for -45 to find -45 edges
mFortyFiveMag = ( (orientation>(5*pi/8)) & (orientation<=(7*pi/8)) ) | ... 
                ( (orientation>(-3*pi/8)) & (orientation<=(-pi/8)) );
tmp(1:YY-1,2:XX) = magnitude(2:YY,1:XX-1); %shifted in bottom right diagonal
comp1 = mFortyFiveMag & ( (magnitude - tmp)>0 ); % Comparison to left-down-side
tmp(2:YY,1:XX-1) = magnitude(1:YY-1,2:XX);  %shifted in bottom left diagonal
comp2 = mFortyFiveMag & ( (magnitude - tmp)>0 ); % Comparison to right-up-side
newMagnitudeImage = newMagnitudeImage + magnitude .* ( comp1 & comp2 );

% figure(6), imshow(newMagnitudeImage/max(newMagnitudeImage(:)))


% The comparison for 45 to find 45 edges
FortyFiveMag = ( (orientation>(pi/8)) & (orientation<=(3*pi/8)) ) | ... 
                ( (orientation>(-7*pi/8)) & (orientation<=(-5*pi/8)) );
tmp(2:YY,2:XX) = magnitude(1:YY-1,1:XX-1); %shifted in top left diagonal
comp1 = FortyFiveMag & ( (magnitude - tmp)>0 ); % Comparison to left-up-side
tmp(1:YY-1,1:XX-1) = magnitude(2:YY,2:XX);  %shifted in bottom right diagonal
comp2 = FortyFiveMag & ( (magnitude - tmp)>0 ); % Comparison to right-down-side
newMagnitudeImage = newMagnitudeImage + magnitude .* ( comp1 & comp2 );

% figure(7), imshow(newMagnitudeImage/max(newMagnitudeImage(:)))