Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9016A357D0B
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 11:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778584982; cv=none; b=ShHFtKQid4Wh2Wd1+Itduey55RXkGmWGpz1zMq6Z2P1LUd6swiE7KNVg1u26NV2hoiEAgMxhwGUFlsBDQR/sFYP4zroSwz+8eQKcDQA8h/S+bRuO476yE8YkqlnsMBYmgXVdwMeHAB+GvgZEbeAqFwNeXF0df8deUCfbVXY4ORo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778584982; c=relaxed/simple;
	bh=WiedUllKP5LQlMEpKVmgR6jyDGxqakz4LohTu34imYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u10lFkxlMr9jf41hr/718LAr9PUJOEmmSicFoJY1w9IrnG9CIbBjoDNxHIgy6AqDmlG9Ne4haCcEV6Suq7dw3RG+fEDI3wEGQuDWD3YVZH8GWHNCbWVylV9LXEG/8Z4efchHQjmY6CQ193ViPXn2PEDLJOVEmyCTpy7qAlSdQZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFoCcEfJ; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFoCcEfJ"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1335cb20406so666376c88.0
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 04:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778584978; x=1779189778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QXIRGdEZlDNlu9gJ4QIb0me+oQaUDZr93yY16iQ8em8=;
        b=ZFoCcEfJU4wL7lEF5aJDWhy69afRQXek7wX7CgVY0vhprh1xklvh1SWAMimUy/3i2d
         W607d7GpBwpl1EFZPBJVos1MxFMNIDVIOLwMlDnDzuMf2bOx+l2WO5O4055TdjXSFlDS
         EvmERppfa4/D8sIrg0SCqP4nxdSAulyBzZn01SWh6b31TdtlfRLIj//6FwcMdRq2qIIE
         oaJYjCPJPcr7Xvn/0WfLRlMB2o3g3O81r9SGw1YYy+e7AyzCkgKDnAmReT/XzHg066a+
         qzU0nt/k1id7DIAdsoBX1LhlaMJSWdrDIclOxqSnPez6QchpneBGT4ChxesAWlTiXFJu
         f49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778584978; x=1779189778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QXIRGdEZlDNlu9gJ4QIb0me+oQaUDZr93yY16iQ8em8=;
        b=ipDrrZDV6z2syC7XqbpBe4ZE4kHsC+x57ittVyvHgoRxnKB9ugMuOel3IHCpLTdLUV
         UcvnPNdj9aRkZgWzjyelRdSj/GLDptJX4GzQgRncfHhkikW0HuhXbJmjheFE4TP7iLSP
         t7nsf849ooTjwrBujCfpg0DISWFvDM/V5U968nFzEtydBGjFTnueef5cP3sru7wqYZE4
         CchNqjOjyvqrFgJNYiu7DuG6qMHjsONRL5SSF3kJD2hZHktDOUqcS7Ssn/IBMqBsj9vI
         fisjUv9Qck5yz/WLvlyxKofZjf7m4c022rH+jI91PdQdEYid+jDR6fAry/WMNocKxugk
         gg8g==
X-Forwarded-Encrypted: i=1; AFNElJ8wsl/nzPDjbDA5ulPfjHp7DpIXnx9p0b1ZOwvyoFSIo4nNQqJi42zBr025UEoScuxd3v3vVif5870=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQVIKPt+HFfp0VnR5Zq8TkpxTfb8ZAQNfzOkoZCZQXBRQsbB1+
	OnEBbqUHg5B7Qr+WGwKnguxeb4HYecE1Ts4YoQgnTPF6PIt0a/O76wUXX3J87g==
X-Gm-Gg: Acq92OHmxwJPLprtRhygEI+jeSPNicv9Qie4BDM8IedhV7K5Z3+uxdlCBfVw46h+bP9
	0XEw9NF54z9pq1ozdzO75NB2EcR+7gDs5+oExXkj8a8/PvBrdXh+4PVJlhkwwPKNOVMm8f1hExo
	j5a0kbQFvQn10ErfI3XoJ7cYhEmBpd/XSK9nSt5PvTtMgYExqRLjMmjFM3MoCEbfVi/3advVkMy
	WkqfT0STkIfg8hUEATXp4nPfjGXWDLnim24gjwrkvcwOoS0wHGaDt9viz6idxh92a84mZZxs5Xs
	XRX000xlvDB5W+dBrpyZs9wc0c+ccUk2DPT00kt6vKk7BMT90aNBa8M9FPHhx9fAwg94qL72W3d
	0fdPthOp+bOtzOCW7QPG2NkxHbx1APm34xVFMudRdM0VSUn0JwwlCHBCeejlm0gbsqyWGBQ9dkr
	w8OwKNB/9A+iULy/IjxM3C/QhzCbWG2w==
X-Received: by 2002:a05:7300:3205:b0:2ed:e15:c923 with SMTP id 5a478bee46e88-2ffd7fd640dmr1395399eec.31.1778584978021;
        Tue, 12 May 2026 04:22:58 -0700 (PDT)
Received: from localhost ([2804:30c:b6e:3000:875:bcea:c04e:7fef])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f888e381c9sm17088753eec.26.2026.05.12.04.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 04:22:56 -0700 (PDT)
Date: Tue, 12 May 2026 08:23:08 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, marcelo.schmitt@analog.com, nuno.sa@analog.com,
	dlechner@baylibre.com, andy@kernel.org, linux-iio@vger.kernel.org,
	lars@metafoo.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] MAINTAINERS: Update maintainer for IIO drivers
Message-ID: <agMNnD7_QFMsGPlf@debian-BULLSEYE-live-builder-AMD64>
References: <20260511171643.3173872-1-sanjayembedded@gmail.com>
 <20260511171643.3173872-3-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511171643.3173872-3-sanjayembedded@gmail.com>

On 05/11, Sanjay Chitroda wrote:
> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> The listed Analog Devices domain email for Cosmin Tanislav is no
> longer valid, and he is no longer maintaining these IIO drivers.
> 
> Add Marcelo Schmitt as the maintainer from Analog Devices to continue
> support and maintenance of the affected drivers.
> 
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
