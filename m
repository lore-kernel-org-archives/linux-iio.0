Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5422C32B13B
	for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 19:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787427395; cv=none; b=NTKhaI+FLCtkkFD14Cw1Ler7Nms80lfMyl09WMfJWtn5Yr8gmmzzSuYweQmZMTLOTbreYJ7xDUT4PuJF8QVwE5GKiccMQK3UWsc+ZMTRyha2r8RKStrMMyEDhQJfhevAWsQ2qKKfNxpbutxoYJ7O+XkRvXjYsvw1gqDIIOCJcpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787427395; c=relaxed/simple;
	bh=MbxEwNo9hWBmu6Qp0a0JvOpRXaZcxRIfF//JVvtLqaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RJfu2IcJvXn/PlJuHBrzdJB2CUSfvcGg/X7SLcCz5s7j+8BoeSYmACPVigwwfhOimSPyEa/yD0bXhJV36BvlkRKoLW7gkPL0cDlG02ddaUDfP0PNh+KlwT/7QtN4z+ZN/dFCMfDwDXO49oIE+4f1k1nYyGmgtckc4HuL6tjgfSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/4OHsH5; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/4OHsH5"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47fecbb7000so885768f8f.2
        for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 12:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787427392; x=1788032192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MbxEwNo9hWBmu6Qp0a0JvOpRXaZcxRIfF//JVvtLqaI=;
        b=I/4OHsH5l9iGNLTuboskQPS/6dtrL9YwYqKrw0Ufk613I1j2lfRIk4OEG7LL2Mh+zV
         bM8LP5MTJlZZTdfwqMX2FmG2sYxY2wtJa+0CjQ0HJb1GbZ1BeGcKHCyUwXMHps4n0hUK
         B77fHxqNP8Bw86N2/KxXSnLlMfyDcB2+yecLbYvrTgOj8jsChCvwwYGxOqOY9/3vovVM
         JrSmGLC0eSuZVflfMXemW6LE/s2qPl96hzzXLWHwz43zpAzNKLEiwM3a9VOaf534rhen
         vLn0YORH/6Fy3EmE9T3YL7xTwlNJvqznFMuqshfv+m3KXRMKYgIsI+Nv/vsdasSI9lve
         jkXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787427392; x=1788032192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MbxEwNo9hWBmu6Qp0a0JvOpRXaZcxRIfF//JVvtLqaI=;
        b=TDivgUqqW3nqtxjoYkROJWpxqKe7U2JmtaXRCbKYw17nAzOXUp5Xr57iMltCtly2WJ
         2i0TKd8hvCg1RyX8xfr8Olrb8BVz5Gs4CBslBI3VcG4BHzo3XlkunyiyOtxaVQc8Ueqq
         gk4StaTtnWwJOeBh0G3g8rKRui7bB52r2JSP1QSziyAqX27i/eCy1Ovpchp+UDB9rGke
         /Rwz9Xv6Zky5rfwmQm/RD7EQTSJzosqecvsgtzZkgau7podfMo4jj3vrTn5T7RCkXWm0
         vwZqr7soFFMFLumz/fg05bs6XgJUP9sZYuomTsrXLrggN29cMRijKAFPicA5tvhD6z9S
         ZgwA==
X-Forwarded-Encrypted: i=1; AHgh+RqoHhGs9JgEIQ16P4KhvEtxp7z/A2Fl4E/4ctI/CMoANAs7tGX1GP0a4TwPZkN3cTlLyUtjkWSjqM4=@vger.kernel.org
X-Gm-Message-State: AFuF++nqePcmH7CulcfUBWnxSpxAYoQ8uEGG+Hpu0herk1THYaxZKbe5
	TiFLDzlS/9X4/ySi1LioKh5qEbdL2jGs2Lqe8xReYqFT0+t6VvCu/boo
X-Gm-Gg: AR+sD1225qz3n5Pf+NVtf4YfGxvrGWQkd7hwpFqBZvb/Qo9Opu84jmPptwxDQzkBp9n
	Rucx9QRjoLvumJhXVQxPLVyX7bUgrBwOvlLdTHPIMwIK1Gt31O95ZT7+uf4mBtn1dcKBLyvZdF2
	PbRpthl0lKQVrySgUVL9zMOLDDm4wrCJGHUNkHWb25jXiWhUQC7Tea6tEEQeF9neRmcHZSBj0J8
	YiaXiN+IZl2vhDY4gt2KNiX1sN0DZ+RNbNdejA6HcmJ5gm789xtVcyrJMzWZWrIUcDuqXJ7GO5f
	7zB1y18prypdwKwbCjDCUDS5wZwkYcLvwtwleZO/se3s01S4r5Is/1vDE342nQBGYymb0YfuEFu
	qSTCm0Tqx0nJYHBOkHi+MP1cnhx77WjUF6QLKO1Ygyxxo7GdqD9Q2+sZYbAnP4VjbXSgAp/r7Ye
	AXVzEKSVDc8p/YWxCirSwXoYEYb/mpHJvv0CNOSPGA6LgJbIVH4JM20v1+l3JDT2qwjrp4cHfyb
	vaRWTUeAQ==
X-Received: by 2002:a05:6000:26d2:b0:47f:8d71:210a with SMTP id ffacd0b85a97d-482c81c5a4emr6272976f8f.15.1787427392334;
        Sat, 22 Aug 2026 12:36:32 -0700 (PDT)
Received: from fedora ([105.74.8.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482c9b855cdsm2878142f8f.16.2026.08.22.12.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 12:36:31 -0700 (PDT)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: dlechner@baylibre.com
Cc: 0rayn.dev@gmail.com,
	Michael.Hennerich@analog.com,
	andy@kernel.org,
	conor+dt@kernel.org,
	conor.dooley@microchip.com,
	devicetree@vger.kernel.org,
	jic23@kernel.org,
	krzk+dt@kernel.org,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@analog.com,
	nuno.sa@analog.com,
	robh@kernel.org,
	skhan@linuxfoundation.org
Subject: Re: [PATCH v6 1/6] dt-bindings: iio: dac: ad5504: add output-range and missing gpios
Date: Sat, 22 Aug 2026 15:36:21 -0400
Message-ID: <20260822193621.18800-1-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <f35aea7d-0844-426e-ac81-d5b156b60e4a@baylibre.com>
References: <f35aea7d-0844-426e-ac81-d5b156b60e4a@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This is one that is starting to emerging as a common name, so I would
> call it clear-gpios instead to match the same name on chips with a
> similar function.

Worth noting Nuno asked for the opposite in v2 review, specifically
to match the datasheet's /CLR pin name:

https://lore.kernel.org/linux-iio/a79296dc96215a579c29c5c9eda464f818f050d6.camel@gmail.com/

Let me know which name you'd prefer given that context, and I'll
update it in v7.

Best Regards,
Taha Ed-Dafili
