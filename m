Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502B63B585F
	for <linux-iio@vger.kernel.org>; Sat,  3 Oct 2026 04:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791003552; cv=pass; b=L0DDKfz8mfVfcIYUPBsqcZi1W4j4ubq+eDms3TPAngQc9eC5P577vI/65V9VXzTNT9HNXptNO0129JXoA9PHE9c9HqpFUzNYqATPH7vKF7Qj6abvybE+TSfiFkF4urjtyA2VkMFauKGdwvXjFBkzBC42CYzX4uL/Ow1E3DLhgBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791003552; c=relaxed/simple;
	bh=ZLTE2MKfj7oX+J0YHkJb4yQZ7AHwrqVbGOY6k2lcfoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HEQrge4/Lgo9GB7hqcKNY7wnzoQKXEC/4Lc6JO2a2nYOKzvP+68Z9VNwGhLqrou1/lK5gUnaRr1n2jyIZC+SHGtQsL9NWnMgWN8xV6oHOAblEOzBJKGpnQmAVTvH4NW4OKaC4waHBkR8E9a1opE9RL/unuQmh2hrJzyIXMvWNsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HpQCAy0w; arc=pass smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpQCAy0w"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-469fdb78b1cso86014fac.0
        for <linux-iio@vger.kernel.org>; Fri, 02 Oct 2026 21:59:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791003547; cv=none;
        d=google.com; s=arc-20260327;
        b=VPrWh5+Xzb1BtMxXEa/GfkNNf5gjRIdslDLciNUy9POYcMb601ln7bCtSZ9zssx4h1
         XY5Xdc87E0E8XPQOXUvkHpT3MIzbmZYzE6fe8VvB0ZRxN3O7U5ps42jMzYTPacET/83/
         yl+skF7ogv95kSYVX0irngVA3jXbjaFysZQJqWMyJ+TtdIFC76squabJuHU4P3sR3XH3
         J7gFO7N/CAFb0vy+Z4TQ4PUi+X09AWW7xfai1fpeK7b8uDUDL8ovZww4dh2GDcNIn+96
         uN6EnUYZysiZZ9lXGZXMeI101c9S6DWh4jXiSJCuLTPG2uRBen2m0QjZbHaRHoKQtRb8
         eBbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZLTE2MKfj7oX+J0YHkJb4yQZ7AHwrqVbGOY6k2lcfoY=;
        fh=/iMn6UHX5sthnQI/fA4mawVU0VIWfHEBRsCez5MppgY=;
        b=S55k9bAyd/M0NjGl+FrtRV4DwMYEY419XwNwBe5aoKeeuG0t7wPub+oGOjjitVHR7b
         95bucSy2Zx7z3b424WzYFHjIYdL+v3ltEUZ6bJjl/GGOcpNl3iLDVn6PLTsOTipIausG
         ZehLEfUOI0YN+hpHlQXc0sDvfv5dZRNyc9+DMk/mJcP5F375+pYiQAN8sa+iv6a1Uf3n
         c/EswpLb2UOZvgaXJOGSKDFF0Zh0R50bbzR21j9C2FJ9y20XMp/uMXQG91M6ho6WPG87
         oOdYRHA1xdgdt6OkhrrQDP4V1i0DNGF5LVRkQwTB7RlK2CO+rhcFr62Uvpuk9aiIHE3Q
         EiyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791003547; x=1791608347; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZLTE2MKfj7oX+J0YHkJb4yQZ7AHwrqVbGOY6k2lcfoY=;
        b=HpQCAy0wFV3TSpsMHi8rX8dXg+3UW9bYzn5YPGd34SVi9JALdhfSvF49e/IST9u7X4
         EUaQ1nbrmU3TIjrNa6EusGjlLuwNDyNZuyaXLDk8UPjsuPrEGS7az0yRpBKtRgOplA1H
         9I8U/CmyGkHRo2yiiEP8LbJRhASPJO0X1ml/o2REG3BfbzYLI9MdXPdC9vrwpm0d/EIw
         k6QeMiPdg0XOQyTlQ9xE3h7yJPvNZ2x6GwsPvhVF64kRpgmq1lvT7uqJYor0M0RzdV/3
         ZigNMrOPOH0bm6RM20uvXH3GEIocSY9wXyS1uoz+ZS8IGXtib9FuzRuVxFhvV9E9OhSi
         vl/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791003547; x=1791608347;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZLTE2MKfj7oX+J0YHkJb4yQZ7AHwrqVbGOY6k2lcfoY=;
        b=mLMIeYAJuV8Cgrr3Za+TAoqKgUqgomxeY3xk+OJBSEtHdzwwvBmDSVMt0qs8yKqjRm
         8Dbs29YMbE8yKUhC7jwMaLhAhG1oVgoykq/3q73JwvuAKOLucqjfT+d8cHAO/LbyB5VQ
         NDcF3oIo8PlgIGwZZcM5yixJYPOlmVRlY3jJZSzd754C+w2jH+bhChrCr/gTyW99Ytqt
         viqlF4+tcV4jmEYRIaubqBZdkuGdV6dLEPFyVfo18cWHhbQc+6kmSo0uh+FTmmGUU8j3
         Z4RuIGuEavgJ3Ci0OulysvO3WuX2GwzAOMYQ7OM9Ug3vu7AxuJksz0MzFKRrCnj7iRBk
         3NMw==
X-Forwarded-Encrypted: i=1; AKwUvBzbw/KLSsY5Y0JaEmYUY/ycltk1Nfq1E+yIpr0abiasipih/Y6asaRfcEYlF+EKMCtWfp/t6pmCqmk=@vger.kernel.org
X-Gm-Message-State: AFuF++lFz3PDtdgfOBVAsCXVAFkm3pqAZ4gbysIyclspixNi8TJpJs9n
	rVcqLMe/63Cl/3RdxEqKnq9RVzfanJRdPIisjIl9B0zbW7yNpl1NaxkPAcUWWadD5QrG446C3Dz
	h+cosibdd5ZCyb/09/8x8v6sSUHejnavLIXXA
X-Gm-Gg: AYBFou029YEIgjma9xRBd7clhPVzUWgOND6svmPkoKzn/T+EA0QLD+QkysM3nBQnsM/
	SGFRsbbsOK7whQ5gRy033t7CrRf0tvjZMeSQkOFw2pH1psW+MWqFhTDQ9bIKAkPabVhABPSNcLA
	g6UNr/hqD/+7IiAouoIe4hICxIWkcKuyp3DX1G9cX7sWUodSTa0M18kutZf7AgG6aOLAftvfmWl
	MqXEBb08uBmnPHSGNnvZK99IfGapGggfbUUTR0XFu8ZjwJBv5HB5Tn7q44/7KT/G+fbmwjY2Dss
	aV3PzPWRTKJJmf8NLvvYNZtRZSQrGlUr/lpcFrwm2daG1Khan61MCbB0
X-Received: by 2002:a05:6870:6392:b0:49d:ff8c:205e with SMTP id
 586e51a60fabf-49e15e0f1b4mr4145457fac.29.1791003547211; Fri, 02 Oct 2026
 21:59:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929184900.39515-1-abdelnasserhussein11@gmail.com>
 <20261002153302.5c64819d@jic23-hlaptop> <CALoEA-z6Q3YyYZfLyRixk9dPy8mn+mmVJVUrjoCZb6T7FXcDSA@mail.gmail.com>
In-Reply-To: <CALoEA-z6Q3YyYZfLyRixk9dPy8mn+mmVJVUrjoCZb6T7FXcDSA@mail.gmail.com>
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Date: Sat, 3 Oct 2026 07:58:55 +0300
X-Gm-Features: AclHuK-DJYCkVcKcz3EQyuz62gVz_--FKN6noxc3KcgVxv052URH_j7bypIZRJk
Message-ID: <CANpqX3Z5_RHPHFCCovZ1jXiQcYgkB5uJVzAKX02udzt2+KDcyw@mail.gmail.com>
Subject: Re: [PATCH 0/3] staging: iio: accel: adis16203: fix axis mapping and cleanups
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, gregkh@linuxfoundation.org, nuno.sa@analog.com, 
	Michael.Hennerich@analog.com, dlechner@baylibre.com, andy@kernel.org, 
	linux@analog.com, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, error27@gmail.com, narcisaanamaria12@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

I apologize to you all. I am the one primarily at fault and fully
responsible for this mistake.

Jonathan, thank you for letting me know=E2=80=94I will make sure to always
check linux-next moving forward.

However, the important thing for me is that I still learned a lot from
Joshua's and Andy's reviews on this patch.

Thank you both so much for your time and valuable feedback, even if it
was on a driver that no longer exists!

Best regards,
Abdelnasser
