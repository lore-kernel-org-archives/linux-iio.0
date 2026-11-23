Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795424292;
	b=XfpzCvtq1KWFIZxHGynrBvMVR6CZzSjHPuqoO6u4vmqsGkHk6cXkUpUbC2m2aHrdQTyT
	 Rn6/ruBHdK9Y2Uv35O0F+eJPPXXVlSNRa2gh5F2ekg/k1XJYJtbhbs+simUYTguGXaDpo
	 +CdFr6I3gZkW6noqGbVeFRbShUTOSbGVi6dWo9CQ9MXS9CNX9ctw2No6ubhg83U4aLi5K
	 Zs9Cg7B3dsWaXnlSv0dwAVCvicoJ5M2jbRJ5sHC8s6BUDogVBYbZ+IX8xG/5LkMzXzcEz
	 oNucDWkMjr7EsWF1OxIxQhzbR52I4+4SKwavLaFgBhUAz4VI4S3UPMr+WZpin1OpbwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795424292;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=l+9MbVvTDshgnA3ihP8j4dNe/hCNqTIen79WI8/6oxE=;
	b=PNV5GqAmK/CMNQmH+CXXYajzT5RHfHxtk8qnS7QLfseLfxC/f+YzxQUfYAtR3T7YRwDX
	 S4R9o2wXa8k04CswsROHmr6ch5P+obCdQQf1HGGTYeZK8Aq8Z5QlizjoZh+RS1Ls37FeH
	 581cFwq5uUdHkPWK1PXig70xk67yKKNkItRdkYhAC9geIHdFacEf3ES70wA2KJz+tP0zT
	 IcDj3a+/Fq0sJ0DFKSuOrudBFz8JU5Tdu2FrK1cqaz8HmJ4Hw9IC0KOcYukxzqXxgKePE
	 JtvU1roTuLxO/JBGvgFN2uPEFIjUhT1yFPE9YlAKKtJWadOk6u1hxOOSyc0pVXxFxHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=KUI7vxQE;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40CE606A31E
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 08:58:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D40CE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=KUI7vxQE
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4bb9d8e8e90so1081425e9.3
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 00:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795424290; x=1796029090; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l+9MbVvTDshgnA3ihP8j4dNe/hCNqTIen79WI8/6oxE=;
        b=KUI7vxQEHVSgYI0WTlM0iLgMy2gGH6gN5WINMssJRuZLubhxgA6SJdej7XEoGlOyjm
         i4dhZaiyMAhbmJuWcQRxoFcIRzAit0hWnSnf13BZg4bbyexTeSssEEugVydrZyoJvQu5
         4myY/NZd0HH/cqTLpISAnh4h1Tf5kp+h+ffzmbfxQoMbZBdXZ4ItwbDfW+Qrq4Pr7wxr
         VsBzC7uyUkxRk3gSL9lU6tztd9GAJWNvvE3HZI16zAVjS6Tznh/34n2GNhqe9ac6cdVw
         TcPURStYdLmYywEv6UDc8e7CtNA4rCcQMfwoIvR8D+M4WiBnbd6HwESUt+lvdAw+UZ1L
         LvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795424290; x=1796029090;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l+9MbVvTDshgnA3ihP8j4dNe/hCNqTIen79WI8/6oxE=;
        b=Yt/jtSp7DXbfwyA2/0qwpq9qdhnXSpy4HVPfA9SmDchadMBfECTWn4bsSY6M2CDvTo
         +cPAASL0FZOCXWXv1bYL5cPUanzn46IV2DZPIpqnN6k+9ZRJ7VbK78siIoOW+LMXUPpN
         O/T9NM6ZhWqFHHTh9JqPu7ITrN26NtjXDqhISGeznYRYUezUgwogJVhNkeX+xWGt6cPH
         e7pLlFzOmuuZoaXkf6jCfn8VraDMAkDF4ESfB+U3WKi3zzi6w537b9brPwUCglgGCN6+
         MDlEnF4UPeSFIS6NOI7yL8oPEhXKAklVPq2yAZCk+AYjGZ9ZgpEybKbJumGtj3Ez029I
         Zr3A==
X-Forwarded-Encrypted: i=1; AL+hErGCDLgPiKNPhrL8Yc2E0U0LF6MEtrOQICU0gMBQA+QzqN+qeJty6lBShRnB3Mq3aMrEt34Txm4MxXU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8QJTtkkT+gVk4UU7PVVH0ietRkKSwtD+GnOMIEDdH09MZGpFSR
	GWdkwk38KS9wz9/YbGm/vWTdcOotYphHC6MLhcnHUzC01q+y9JmsZnblt2zJDTvsEhY=
X-Gm-Gg: AZFdTZeXm3rtlbxdl8phN4hfopHc6RqTLkPHd/bNI4zVvfca6kPSOXkjkJDvV3Fdijm
	kPqRVh5lUlnWTHPNtoEBuuRUnJc2ieOFNZ4FOAtgdQHNO/Hxth4Xdb5tqlkhvbAaNRpOq5fRZhs
	+VE1K2TLm2ALl/s+8DnZiXolGTfvmDmfuQNEfMbw4zXWuVuUmNgdhYxr0whgILtxRJfzvNvD2aj
	u5tqKplW20eYZjKzE3HM49c73p2WfU6R+OP0geFq0DCZ9qlpEOYWrisLAqiduN5XYlO/ui/trHV
	NwXFLVsvctBch1LP3Jlat6+KoKHK+XrnJGXavUipVsRgKDDOnwwxg2sQ/Q98nZFza6NquEcuQU5
	4PHTeNWWCqX0gZ0bmJGd5/SckVI3sAnIaKjtM/Y8YLd4jJNMmUo70R1zEd4fcgPaj2L0tNtMai2
	IoSn8R80BXfdDBY68QMJN+XwZlJLzViK6XpV1Edl1d3P+oSSIwAqQv1V60Iz1xHodeXatCLe/au
	swAYdgbP8IFY7EUPSdNt88RZF9P9lTLZQQz1KIH3tRABXJ8i9vWOqRBjtq9Edx7Gwz6m5gNqRK+
	r0NkS84thaSkWEJKRpu5m1Yf0CmukHv910TVG6kpun+DX+3xXHfBKp87hOySvtbEasY55u/roD3
	obtj/g98i1kXRo3oCBazw/JKkqrPxgGslOWt55g==
X-Received: by 2002:a05:600c:3f0a:b0:4a5:75d2:c104 with SMTP id 5b1f17b1804b1-4bb8880cde7mr211375095e9.22.1795424290183;
        Mon, 23 Nov 2026 00:58:10 -0800 (PST)
Received: from localhost (p200300f65f19a90438645cebc2ee104e.dip0.t-ipconnect.de. [2003:f6:5f19:a904:3864:5ceb:c2ee:104e])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb8849247asm331942575e9.7.2026.11.23.00.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 00:58:09 -0800 (PST)
Date: Mon, 23 Nov 2026 09:58:08 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, nicolas.ferre@microchip.com, 
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev, giorgitchankvetadze1997@gmail.com, 
	amin.gattout@gmail.com, antoniu.miclaus@analog.com, gregkh@linuxfoundation.org, 
	mripard@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/8] iio: adc: at91_adc: convert to
 device_property_*() APIs
Message-ID: <awP_vX8zyTNCZGUg@monoceros>
References: <20261123070101.53868-1-abdelnasserhussein11@gmail.com>
 <20261123070101.53868-5-abdelnasserhussein11@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yb7ur3sdfis2fllo"
Content-Disposition: inline
In-Reply-To: <20261123070101.53868-5-abdelnasserhussein11@gmail.com>


--yb7ur3sdfis2fllo
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v5 4/8] iio: adc: at91_adc: convert to
 device_property_*() APIs
MIME-Version: 1.0

Hello,

On Mon, Nov 23, 2026 at 09:00:57AM +0200, Abdelnasser Hussein wrote:
> With no OF APIs or struct device_node left in the file, drop the
> <linux/of.h> include and add <linux/mod_devicetable.h> for struct
> of_device_id.

That's wrong. <linux/mod_devicetable.h> is a dependency hog and should
not be used any more. You can rely on <linux/platform_device.h> to
provide of_device_id and just drop <linux/mod_devicetable.h>.

Best regards
Uwe

--yb7ur3sdfis2fllo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmsEAB0ACgkQj4D7WH0S
/k4jWwf9FOlwkqlYHms84ZIP22YljXL5kC4jGI63Ce/xclPb7V+GpzsB75YAqYlm
GWJKN5/ikOKhG/Nz/hTDiqbmVIgcqG3XOULPz4itm7V2+ZTQyRvfQsirNJzDaxTQ
PFo7krPE3pBFSIBcvunsQr6/d+VMNUhHY0rSDcr2XsHs7BjG29muEdAbr/TLYdOe
iqt0GzTnTD96mAJSESDLQWCtgNb9pbl/El6PLhlXyWPmkhj3kIRMf92w75zB2zLs
JEpcrCMaIBg/wL3OE7CyZuiqEENsbh6jmorJXFqTOEps80hcJbNlOaN3RDTKNnG1
G1xKxDMU6BQx3J60p4ovhMokWQcSkQ==
=t6hY
-----END PGP SIGNATURE-----

--yb7ur3sdfis2fllo--
