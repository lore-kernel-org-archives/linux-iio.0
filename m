Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794521432;
	b=V6V+kv7SYRa2sMlwcf6fhWVrmsLVyFk+V2nfLV/I97xklhNvCMKcHx/zXjy5/xxCZvwy
	 xd+Z3dWcwKlzypS1c+Sx5Od1flihGrXwMH73nVlWk8+uUHG4hYe6uyVIIZ+PE/CqJFAS1
	 NDaw4FNsMrzYxvAKCjj/sjR54KWnpTW8CT7baQLQjWn89jGjP8bL9WwY3X2pn0kAyfTCd
	 PMicA+qNNT+X6Yf4w0JETh3J58AVXDYlPZ50aqxwl3ITuWBHkbSuS4RiDoyVMHceL17Ux
	 CdA+xZaT0ezK/8BMIOj2/lsjt8x9h0aMnq/p53D/Mxs3ZpD7qyOlxQr4I0cizsIaKPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794521432;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=aEfafPymAY1ju6OZbZAnj6e5+ZStzszPQQTeE4b0erA=;
	b=DZnLEL0UlUX3GRCvwEyG4ujrVrtFX0HRmf+4H8i9qRrLY1jfzdimdHIAFJhEv93HwRy5
	 Ro7Ff0mviKZcMc7jMtgM8Zx/k7klnRUm0df3d43x8NsKH0OS5HanP9VXnLiyHN+njVKJt
	 wX1yu0+JS4UWP9Ztf7Afgua6d2o+txr9o525lGqQqI3jDfczu/JYeo9bcM2TWVgA1cCYr
	 45aBtDNcnoqHqm+VO+cpkYYMvDnfNI6DFoRwYWECf7eFJeZLCvVO0tLCzRQdhOFn453nt
	 IkcU/y7oPH+LTR0DqNi+Nigkek830KHrQguEoIwXC7DUigBlcdDI3jIQNXRrJ1vLX8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=slzuCEAI;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AA5606A889
	for <linux-iio@vger.kernel.org>; Thu, 12 Nov 2026 22:10:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36AA5606A889
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=slzuCEAI
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36a315ed211so284154eec.0
        for <linux-iio@vger.kernel.org>; Thu, 12 Nov 2026 14:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794521431; x=1795126231; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aEfafPymAY1ju6OZbZAnj6e5+ZStzszPQQTeE4b0erA=;
        b=slzuCEAImnD4jqWAMEvntSEWJ0U4ruTCHHB/zPMILhLk6k1uqXgAtRrnAo+/pa9wab
         ynvnTPncvbBnPJcfgytu3tBxT0qB3nIkpsl2gdQZl28jJDuOYmxnBzzaTORfhTbeJ4Pk
         1ZV6Bc5NmGKbhSB2aPurX+7nE0yfPeqekuS0BtbdNqYO+Sl/I4KkVZKsIQHK/MfuGUZ1
         V1K46jOf3V2Bmf7vEwtE8ITypgrbWrF/keGp7HLF8CEZzTZBLfHE7cMLTvP98tjmIkeW
         dbogzYZXhUXRvWnUuyW//7xjR5NQWHikYxISPpurBgQuTJqXRvx6j3LFNbFJNzfZbZKk
         Hy+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794521431; x=1795126231;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aEfafPymAY1ju6OZbZAnj6e5+ZStzszPQQTeE4b0erA=;
        b=Xao91IBNsf0gxgLZwIyuRAgTjWUXwEPwPYbBqNvp+J/RQQ6nowdLdpdytj2EGpeo9N
         w+0D6Jl9NDD8gRe9Mhko6/yX1s9w+VXQcyOnbI0jsDRHjyo1ydIcfk5nfJYEq4kcp+fW
         MkJvo+iAbH+CYncacli27wvorQ+HI+jy31BweypvIqvIDC/gEjJ4OsDvApvVsnerLq3R
         8wqzqkoROUm+V43jqfBx2sJUJaJn3zo43iDqANIRv0iLFaJqPsjKNgmv7LVYkeS6iLx1
         HDhHMgDOiI2frp9jOSZiexjHAqKq3BNKvP7VsX5Big9BbWBV5vkxi2IWj5dMJlCVWzmW
         Bzng==
X-Forwarded-Encrypted: i=1; AL+hErHIQJryR8ZJE5On279T5lV6ULBHQOCxWJAiQgM/+wndcSYk/aMZR9LWO3RWQW6lGxqlcCXheQSVwV0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Cf+o9X6fkEItkBs88xJhgUPhygZBjTuCo/tmv87DAMxzutnhd
	CEr4OwiimNmyw2w24VHnvUk8GWqg2LSJ2x9AVS0Tb8YPgXAlqiV49Em+
X-Gm-Gg: AYBFou1u2VEXxJD+RgqqLgIBq7n4GLRks4EOuXInCPnjCGVA18vElc28mN3LJr3pzy2
	dCMfJy6gyrxmYPQwICql+Sc+irX9xyB31bIGL9qjrcBFHOrwH6qK8RcprKsA4XLZZSEBh7GcCJt
	iTaXYr05aaYR/SImxqqimYGm49J/bf2SlMC4tsWIzzw8D7QdNPrXj6Od/uVX+8bMHFJGmhKgB1f
	fJXacY6LdbVilyg12E4n89JVcuV6UqO5jyZFVWQgZejtU2v/NAEPQThSGQgX0dDqNR77UtUxolX
	TZx8RvfX6BiD54XMWDWNhC3NfWDrELVsGEWl/MER7MOFzkfQLs/Eupyq8gaG+cB+mdp7SvJTD5a
	hmOw5cZhGaJUtKfCOdgP5PhcTkYxHunW3Lne9VuVM2graukvyNfZrk2DhSAuomfLl1txLXeGJxI
	/Uzpd8txBnn2jCPNbiyMQnpviT4u0AbMZQ4MJGkE7kfLOThBUaPgZ2CSRKan8Jfhy8V0BiwKLaC
	DbvdBlLYeAYqlNBvAVV9ZWshHg2jkaRMCTyaj4jfNTOynQT2eNt2QHQs75R4owhsMztnoKhhpvA
	tE7nbznHhNEqPt8VCGkSkVPX2niGsdVWd9g759Fj3bsP2bfGRCUfpelMVixetXPgcIvOf2kt1Hn
	wubtJ8ohfpQymqXVMtuSI7W2M5KxD3KAiZFuMLg0wZtguFEx3e+M2mHCZiX3G79DpPb78F01PXE
	ZIcHteesZzSeHTnjuGBeWh+GQjJySyFANNXoY5qB6iGw==
X-Received: by 2002:a05:693c:87c2:10b0:36c:a3ae:936e with SMTP id 5a478bee46e88-377e093dc83mr3350875eec.5.1794521431203;
        Thu, 12 Nov 2026 14:10:31 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379565d07b3sm1079471eec.22.2026.11.12.14.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 14:10:30 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Stephen Boyd <swboyd@chromium.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] iio: proximity: sx9360: fix hardware gain encoding
Date: Fri, 13 Nov 2026 03:40:25 +0530
Message-ID: <20261112221025.509996-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107191409.0e4acaad@jic23-hlaptop>
References: <20261107112335.444813-1-kapoorarnav43@gmail.com> <20261107191409.0e4acaad@jic23-hlaptop>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, Nov 07, 2026 at 07:14:09PM +0000, Jonathan Cameron wrote:
> The default value is odd.  Do we have any idea what is in that top bit?
> I'm going to guess something harmless and that perhaps the gain value
> due to writing a 0 is either rejected, or actually mapped to same as 1.
>
> You are correct that we really need someone with datasheet access to
> sanity check this sone.

I still don't have the datasheet, but I found the vendor driver, which
is the closest thing I have. Samsung's Android kernels carry an sx9360
driver with a Semtech copyright, for example:

https://github.com/TeamWin/android_kernel_samsung_d2q/blob/master/drivers/sensors/sx9360.c

It decodes the same field like this:

	gain = (gain & 0x38) >> 3;
	if (gain > 0 && gain < 5)
		/* prints "x%u", 1 << (gain - 1) */
	else
		/* prints "Reserved" */

so codes 1 to 4 are gains 1 to 8 and 0 is reserved, which is what the
RFC does. Its init table writes 0x09 to PROXCTRL0_PHR and _PHM, i.e.
gain code 1 (x1) with bit 7 clear. That doesn't say what bit 7 does,
but the vendor's own default doesn't set it, so I think 0x80 is the
same typo as in sx9324 rather than something intentional. It also
doesn't say what the hardware does with code 0.

Sashiko flagged the same off-by-one on v2 and v3 of the write_gain()
series, though that is by the same analogy with the sx9324 fix, so it
isn't independent evidence.

If this is enough to go on, I'll respin the RFC as a patch on top of
v3 of that series, which needs SX9360_REG_PROX_CTRL0_GAIN_8 to become
0x4. Gwendal, Stephen, a confirmation from the datasheet would still
be very welcome.

Thanks,
Arnav
