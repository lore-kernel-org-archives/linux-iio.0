Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223A854707F
	for <linux-iio@vger.kernel.org>; Mon,  5 Oct 2026 00:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791159940; cv=none; b=ddFIrP9KL9+ZLfN8pSQJLPxL3z6ndsy46ndFOqLDOurBQ4Da6Dp/hLU4Zg03YlMfXFKEkj/tqHvJEQG63dSPaFZtSsUvltIf2JICBCt/A5gfRjgfbyswvJdU+kdaUBpEMI9bZcLsuVfI0uqJ0OyXNTOQrZxVFlCfI4g+/4yL9dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791159940; c=relaxed/simple;
	bh=UjOBKbAKoYtFXedpgYaUu+eAQwTobi8qej6jfEwI434=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tq9vxEO6bKcfwGv0DHY68GAeEB8qcSA1E/jN+tCE/7Z0RR1FhrJ+a++mB1AAT2tbhIGQrNVBQoY/3nZQWDqOZurQMctlO4HBpQf5HeE2EvMtsp0M3A+sxcFc5iDd4avU5zp9WvWSeSVPnk603gngit77+AOsY5KRfwu9REz4pyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Th8sWnca; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Th8sWnca"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-988f270d308so799152241.2
        for <linux-iio@vger.kernel.org>; Sun, 04 Oct 2026 17:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791159938; x=1791764738; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FRktsRR8jsvxEuGT6N6yXFN0RwMzMtvHCyMuqTTf4kI=;
        b=Th8sWncaWdjYhP4jMWC1EEw+aZyoKR8q7n97nwPoM6nGCE+92S+CZDk+Hit+rlS7Ym
         6n+mKm2UUA6WDijYmdf7YMdSxjwjQBXF/pwvYiEb+7vP2UkeFJ2dbSliwgTKxVnK4mz6
         D7uf+hvtht1Z/6BlyKlamFUY5YdfIyX0yjugvkqZ4RnPHGw1kLbwf69BbQVY/SIEJqXP
         Gu/uBoyEVTLulvuv8X3BZcY+Xt4YwMBFYDvh4bcxP4U5kIf/AiHL88lhdSODrkDhoiyl
         cj9AJ++9EndUYyahpsuXxbAFBULrdZgr2sTD1bVIhJ+iQr5puYhngy/riFzK8B+M3qjK
         IhVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791159938; x=1791764738;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FRktsRR8jsvxEuGT6N6yXFN0RwMzMtvHCyMuqTTf4kI=;
        b=SMMHeqGvefVE36m845H++6fFwWkTapmIcSo/AEEp2aMcXgcPTSqc1iIK6EAmJZx2WF
         XddepYjEai9gCHoM9Juy2r9vtVZrD4Yhzfd4riW6Xa2obazsOErTfEdgTnwmEsjcn5/a
         6Cl1eXeUj9ZhOCEjcXWTxiqFRKBAAT6eyvFZ4iPYaaG726y9MUBq4rqZyDQjniCF9slo
         JLgkzx88ZbZHNIn68dv6/uu3Vlo1E+pStzE3OqXAqXS/zPFoQyD1ykrsgaAs2mnX0XjO
         jzFreEtcGRzwM2v6KZTsWjnP5YuzA9n7DsnCnMpDmEFeAWOiozf4Q90EadseEvYJhhWL
         YCfQ==
X-Forwarded-Encrypted: i=1; AKwUvBz+PHCAsL1RVJf3huOf7PdLmMckGX+LbyNQUnG/h4cEy/thwXhr47MkP8ZzLDtkY97OSiVh21kC9rc=@vger.kernel.org
X-Gm-Message-State: AFq9FYK7Sfx2NjcWANQ+aQWcj39lutxfjiOlhftWsJ5wfte5OlbrPPEr
	FgyRB8xI6ejZuXSrIeYz+F0z2VUyyLqS/3EHQgIYtV5GH2D3k01Ydi7I
X-Gm-Gg: AYBFou2sTrONNA4DHxRQlKJQcBCBujtIOlcygkeOwQKV8hjxqQO6P8EM7p9oYInZK5R
	j7jGlDGXSKN4qQhnWDLTfteucrYHbrhh+mWhV33a1pHesbS7uZtkFEGHOWhiFTOI58x8p7uv/kk
	VRqt+9yry8aq/nOjRm6Wqpr+FBAorZOfZ8z22Rz1gVJM52X4X6su7MiRF9rTRL+isJnj4auQDfJ
	bV76fUeu3NLpbHf56HiasMSgF+bj6vph3M5OF9t2oynMhuSZPbgRfmlb+K0EODjGPvby7HQ738C
	vMjWICYcY5+7nps3gcLq3CqkKNdarOj0DxPZCZhNZsu/LOBc9G4I970aBVzR94QIFVkkulLgxKc
	SAH356mp4FsItOLzUgNPtJnueI2CFdZuJ6ROxoES1xMzB+oVHVpAH3ZQh4RHP/XD32i3EIU6Y2f
	RvdHMDw0R183plBUmfsWZ+UFMOPkepo8ECfrzoWBp6Hj2ConwpD2ka6vgUYIBtv9Tw3JwhU4ESI
	8iF
X-Received: by 2002:a05:6102:1623:b0:7a2:2068:6e37 with SMTP id ada2fe7eead31-7c244daeec9mr1578540137.15.1791159938090;
        Sun, 04 Oct 2026 17:25:38 -0700 (PDT)
Received: from localhost ([2804:30c:96c:bf00:7844:c38c:894:4054])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-98b2f115fc9sm8981087241.10.2026.10.04.17.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 17:25:37 -0700 (PDT)
Date: Sun, 4 Oct 2026 21:25:50 -0300
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
Subject: Re: [PATCH v5 2/6] iio: imu: inv_icm42607: Simplify IIO channel
 macros
Message-ID: <asLujlrqvfRirW5a@debian-BULLSEYE-live-builder-AMD64>
References: <20261002-b4-inv_icm42370p-v5-0-c65281b745c9@axis.com>
 <20261002-b4-inv_icm42370p-v5-2-c65281b745c9@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002-b4-inv_icm42370p-v5-2-c65281b745c9@axis.com>

On 10/02, Kanak Shilledar wrote:
> The INV_ICM42607_ACCEL_CHAN and INV_ICM42607_GYRO_CHAN macro had a third
> parameter of _ext_info, drop it and just point the .ext_info field to
> the respective inv_icm42607_*_ext_infos. This reduces the repetitive
> calling of inv_icm42607_*_ext_infos struct in the IIO channel spec
> struct and makes the code more easy to follow.
> 
> Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
> ---
LGTM
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
