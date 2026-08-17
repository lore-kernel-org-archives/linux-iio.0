Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118503D811B
	for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 09:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786958308; cv=none; b=BSnhzdhfEOAk2le1O2OSds5lRvvQZeCf1fGjHsikLUufULqP/NRBYxLLoSs0ous6+ikq8SJAOuGpKgQme0gpipv70L9pHAtWpuVG57egYx8xYCcGk3d3eUps4rqt2zeaCCt2ct1/XFe4MwXfaeqlzCSwjkOF0cRLxnRVRGkOOac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786958308; c=relaxed/simple;
	bh=iXaBam8np7C+h1PSqLUNbzfW2XGwFXd+uvNQzXPWkqE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=goSd0Pla5KzBqtK5P3OC0Ab4gx2B0EjZGPoEDKfJtwyR1o7jEb7330z2Mhh3raZmU3WXdUDF4S/t6QuCtBK3PIi8wB+H4TL+kwnoO7v+2I+ZeTgV5azytQzp8iOYOkGxfSDslzZjVozXf9QdJ+n1mjITCNZc6vwkabxtFKfix58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Slwlmx0u; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Slwlmx0u"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-476a130c138so3311876f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 02:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786958302; x=1787563102; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MDk3a5hAgJy1HWw7PqbxGeNqF102RYP7hM6I5DNLSyQ=;
        b=Slwlmx0uxkIMnsqfjYq+WkUn0LwB+O21MHUyfG2qMvleO3qVU7Ca3pY0Gl8p25+++R
         5mjaIeElHN54pdstDUTntNABvNSSQwVN8/3kWiTpJwOA6hH0R2UcTFzDHz5XK5eicHmi
         r3NbrVB8cjwz46IzDB/zJN0P+Ei7xHfdcwhfzyvwWZtWe6Lx2zWpOoExOm/k5eXlCLGM
         oM/86QYkO4F9xOM+Olcxh73K7Dx2xEURpwbCamLdl0cjaULPJs15ASnxDEPuDZi6yVXI
         q4C+TOYb6sHT7TAqmv/O///4tq7XSfb6t5QnwcBIHa3p86NcKzTYKjW9AIn/8JuOrQOq
         uRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786958302; x=1787563102;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MDk3a5hAgJy1HWw7PqbxGeNqF102RYP7hM6I5DNLSyQ=;
        b=UOydcLbcevJENS93jrGeM/nCJLB2E5lK3FNORklJaMuOwCOh4ZopCdfKG9Cy4Y0+Fu
         K6/fiIk2DFpu+Cd6736mAQoddyDsI4uILwbImgAqnepYdDFHlzLjUOZ0nxHMD+PEFBVx
         9sCnaav67jl/ThXq+j37nAhkwZzcsOhem9a4hYa63/fk8VLsy6qTPvsY+dTfYPCa28wn
         lYRWyf6MgFfabQPlZv/eHDObDu1l1ge1O9t1d8gf7TY/nW4zkrEEOAZESbZuXgwjr+eT
         b7gYZoNkAE3ubxibCJmr03N2uf4/QzJ1CYEiz2F5rHwnsrmTTvmsqiEspVIu0ZOiqzsN
         7BqQ==
X-Gm-Message-State: AOJu0Yyf1cj5ERIaFEMIjPtKwhJCAs9xpLMKzs9wR5h4C2jl5N636mJh
	e/OUY29bMRGWfovPKWQ4DeE+FHViBs/5NJOKJkyA5RkGJ/l/osfMk+yBLOu/p+UcuRI=
X-Gm-Gg: AR+sD111mlruzvYOHsvd0242DgUPtJ1gzf8matnNq691kbNX3xJhgt+O7wEcDCQ7wQ/
	DX6l+2UrSxYPstgwQMeqdaYTstHpc0bjQQHQWMAHPfGWczNEZ01u+FRQmbAi6MECAM/1jAuioUx
	VsY42qL9DE01fI3F3dmM9xHa+s4FpsyLHF2kvqUsvFVnvtC0OgVyVIqQimjdtiV3xjEAQ+ZX/+X
	Z8tnvVkD3zefHtvmqQub8uoJecBWJtIzppUO785jd3lf/Q9UAZaN8vKpe72rWeGAXtRJZkICV+k
	AK1p2+rSlOvG64aTsmLgDXLyIPQnEmJVITKEJ2rDwgIsq4kEYcEXanjTTNSBZiqGgwIfoNC1cKe
	nA99lJQaiyJRY/LWIWk5WYAyJpYl3ZPyis5J2+OCop92H9LYCR9nHdJpBhw7Ha8Gb1fUDwD39q3
	wVTFrClRbD62lIXBgph3g9ZUKsW5iD+b2UGHVph2dsd6ERjS7eZkf9U7sAgEUvbUNaRCFohFe0Y
	9WxbGo+jIwhQ5HTv8LHG1A5zz0/hYPP5gwuFF+upzwHSLR7Bu7qhUSxWFfujAf/xDgGCvz40cbL
	CxeZDY1FoU9N0o+OoiZYnB6hYNKNB5CHlb5BkidX7SGQbDnBW/w2qI9Fb+Fec9MUl5NOF4v6ngL
	UClfEEXMJFHrQKAUMAAcVjPvZYa7jz/0xohWCYHalt2baR/80g4jnHMGhU3E3LkV8TA9lsQ==
X-Received: by 2002:a05:600c:1914:b0:499:726b:7375 with SMTP id 5b1f17b1804b1-4998796a1e1mr361798695e9.14.1786958301866;
        Mon, 17 Aug 2026 02:18:21 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4999d10b7f6sm23406205e9.12.2026.08.17.02.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 02:18:21 -0700 (PDT)
Date: Mon, 17 Aug 2026 11:18:25 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: linux-iio@vger.kernel.org, jic23@kernel.org, andy@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com
Subject: [RFC] Maintainer entry profile/contributor guide for IIO
Message-ID: <20260817111825.000063f6@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi all,

I was browsing lore and checked out the ksummit mailing list, where the
topic about guiding new contributors arose [1]. New contributors tend to
make the same mistakes when sending patches, causing reviewers to point
these out all the time over and over again. For IIO, this is definitely the
case (I myself send an email telling people not to send a v2 in reply to a
v1 several times a week). Other subsystems have a "Maintainer entry profile"
that contains subsystem-specific process info (DAMON for example [2]) and 
(sometimes even [3]) a document describing the code style of the subsystem
(this would be a great place where to mention things like not using
kernel.h in new drivers etc.). I'm happy to create both of the documents
but it's always great to hear other people's ideas! 

Second of all, the idea of having a bot that would automatically detect new
contributors (i.e. the email they're submitting the patch with doesn't show
up in `git log --author`) and send an email reminding them of the basic rules
(while also referring to the entry profile mentioned above) sounds like a
great idea, but of course hosting and maintaining are pain points.

Please let me know what you think of the above ideas!

[1] https://lore.kernel.org/ksummit/87y0ekm9nw.fsf@trenco.lwn.net/
[2] https://github.com/torvalds/linux/blob/master/Documentation/mm/damon/maintainer-profile.rst
[3] https://github.com/torvalds/linux/blob/master/Documentation/hwmon/submitting-patches.rst

-- 
Kind regards,
Joshua Crofts
