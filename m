Received: from mail-vs2-f43.google.com (mail-vs2-f43.google.com [74.125.227.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C1D438470
	for <linux-iio@vger.kernel.org>; Sun, 20 Sep 2026 13:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789912314; cv=none; b=gv+wDQYDJJkJeTAvq8lx5lfYpc8ZOWDxZXYvxj7HIRuAmt/kytSRZ/oJy0LPHxywxPJMUYShpohINSef3I38NoN3njq/XQ/dOsOA/hZzMxOz9U2+O9Tpe8XmY/u1WrNokVHr9oCCK47wSRwCfXwXLndZlXWOXBxqdRrGD0wQe3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789912314; c=relaxed/simple;
	bh=KrFLy4WtI52x3tGQmudiPQj+AzMzloxY/Uf2tz5humw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=axLENbYMdRQxMTn+uaX7nA/G62b7PsR27BKr79FIl+r4TXsSysnvrZxBMmY2aUNGNElGTwm9QGLAJ0Qcn/nFWdr/IdMediHj2Fr4d5fqloPToi2pBjoavaeQzDVE85OGqvMUU2gDI5mT6s8A4tue7DD8ynPbXEbUvVgNvZw1TiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FB4OsaLX; arc=none smtp.client-ip=74.125.227.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FB4OsaLX"
Received: by mail-vs2-f43.google.com with SMTP id 71dfb90a1353d-5c82bb05ddaso1549057e0c.3
        for <linux-iio@vger.kernel.org>; Sun, 20 Sep 2026 06:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789912312; x=1790517112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1cZcmuhfWNSOMdpLlBrDH5176HCDVCbPGuvF5u8I7/s=;
        b=FB4OsaLXs0kF1pBHL1anSrXCMCg05N/d5H48s1i+m079H5/jpkm/AUQI9P+BDDNBaf
         tARc5EbXjFeht+/NbAtt/9k57X3HSM064KlS6t2XEmzB4ataIGlkDrVmIvhYl52RpU0d
         gjShF35W8c9LmD5/PoMFJ9kjyqTVBtNLCB1DTinXzxOAP0egGDglRzystOlW5Q5KpaTs
         vvxhdpPhAFEf6HJ5n8zoeNUY5aquYT44jESujM8WzL5WcPhCo/qIGcnrqvel70BofTWR
         5YpQnWqwW3HJOh1oqf4XZjRXJWeo3sVpqXG/QpG7IORXnm0vJcjvdHw9hWS543ZzJhTE
         yGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789912312; x=1790517112;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1cZcmuhfWNSOMdpLlBrDH5176HCDVCbPGuvF5u8I7/s=;
        b=H0w35B8HWM5gw95OGO8rexqvurCCwyZiQtHG7iwMERf+kEBBuaMaRTfqAwikkMhIb0
         ZaKw922M9t56vN6RXRREFoQjha2p1EYNYeXvz7AfcEvwdyzbxpsUx1v2GyATA0W+OOZ3
         e9K6H1SfROGEaWF/ekNWRqDBsiakQ2mNAIJEloWPerMyQXyFQsKhyCyqY/9SA775F6fW
         wAPew7+Do6WRv1wmrSdyBcpYxhCiKMbwGSOs9WH2BM30yijKMDnR4uk0zKHDoRPN8QQM
         UP2J2h5Dy7u7Ek+8QGrcmOSR6E9nICH89/3TiME+N9s7Rjpow5i5++MtfpnxgmFxMvkx
         yR3Q==
X-Forwarded-Encrypted: i=1; AKwUvBzfGYwr0OIP+RhZ32DijB2wAM4fBZ1rMZa9SBgEUBBKEdM8Sxb9qxpRblYM3WDh3W5JtwTT9pFO2gs=@vger.kernel.org
X-Gm-Message-State: AFuF++nPXza48bdtVagU+vDM0eRKquglZd6QPEXjRXs97cvML5GXgM7i
	26MGwV41ClsB6SLiPNIb4bhBPeo9Q48t7N3iqRLPZhucn6egfARddKqb
X-Gm-Gg: AYBFou3QsuK5ZWHQymZCZqA/5HXdRjaiDqVkfc0gh/p89Tu4aONvF9S//WqYjO+sj7S
	O1K8HhsQ1VizPHb6TPlVUxJatFSLqiSVTdku2V3Yc6s4VBDJZOWVTGwnmPF/fROGPgyJmW2+zyQ
	JTIqgwIUCstjePQQ6TvTSB2oY9xnRHEi0Urb5wu23vrdf1VsKWmQO2O91TwX4HAQReSWFkjB3ED
	bFXa3iJRd4Vgbb63C0FYhHHTcpDPktwrDq3t+RkRWIN2feoOfwDj8L8xv/1oAf5fz/jcPNG8Qm8
	3OaJ/KvFZ6SSmTGVYehRHGGV7nHzNE1JlOD7dQ//xW0Qb4Udnx+miJ/89ge0fdkDhD215Qr/AbN
	cZEuJWMLmtotu9I9/OKhIrNnYhwmUFsjfRJEkWZaljvqUQL1PV7udn1cvDx9jmKMTO+pfe8cbFu
	VIR8masytW84MS8Qt3gsnYOpDsyGEuxIZQiWn/+O1oEOovCQ0qEro7dUmICubNM7hOoIlThhr7r
	PF1
X-Received: by 2002:a05:6122:2214:b0:5c9:a60b:e5ab with SMTP id 71dfb90a1353d-5c9b59a2fd3mr3984408e0c.13.1789912312321;
        Sun, 20 Sep 2026 06:51:52 -0700 (PDT)
Received: from localhost ([2804:30c:96c:bf00:7844:c38c:894:4054])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c9c1932ff5sm4511630e0c.12.2026.09.20.06.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 06:51:51 -0700 (PDT)
Date: Sun, 20 Sep 2026 10:52:57 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Kanak Shilledar <kanak.shilledar@axis.com>
Cc: Henrik Grimler <henrik.grimler@axis.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>, kernel@axis.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/5] dt-bindings: Add InvenSense ICM-42370-p
 accelerometer
Message-ID: <aq_lObgrI7uAi0K1@debian-BULLSEYE-live-builder-AMD64>
References: <20260917-b4-inv_icm42370p-v4-0-fd9373f123c9@axis.com>
 <20260917-b4-inv_icm42370p-v4-1-fd9373f123c9@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-b4-inv_icm42370p-v4-1-fd9373f123c9@axis.com>

Hello Kanak,

On 09/17, Kanak Shilledar wrote:
> ICM42370P is a 3-axis accelerometer. The device can support I2C, SPI
> and I3C. Add the supporting devicetree documentation for the device.
> The device supports VDD and VDDIO operating range of 1.71V to 3.6V.
> 
Patch 3 says ICM-42370-P is almost identical to the existing Invensense ICM-42607-P.
Instead of creating a new doc, could we have similar properties for ICM-42370-P
by extending Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml?
The updates on the other patches keep supporting both ICM-42370-P and
ICM-42370-P with the same device driver.


With best regards,
Marcelo
