Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793037354;
	b=JvAzQ8bS+WF14Sb0RwH2+Onq41vMM1MpuwMZ3t3uIy4AWDWNbQRZyqqB+LzaigHT4VMn
	 utVlWd5LEYCqHdooV/rDkhBAzdlxMNYb4iUsTDie6Ukj6cWrX71IKJd7ZdKP6j5vivR8o
	 57wsC6iGfQ5isKSkotscuMdfJX2sfa0aOeXdwRQU9QoQdyptgUSpAqyDe2unOZ+IYjtt4
	 0BI3xd6SOaUaFALv2PsRnHBCpWVkrx12A1/cGDq8pWBrTBwxEatF/2UasPfyPJWb4Q3Za
	 fTJ3yTnAAiaJuMWmJSHiXDM2hdossJ2ezoLgd2is4U7L9lUflF3hXLAW6BnQWja8JHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793037354;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=4+gIplI1IodfSwpuILgTs5fvrOniSHigUSugOeDsgyA=;
	b=1fDirFVJulWAKnp+e0eMHeRkXX4MLyr2ZTfjxKPwM4CxuONjirXl32VsYpmkZVXRjzaX
	 1kXemj6OMp6sCjZHguDhKQrHYVwjbVHfASZKeMtOEdeXr9/sOBhPJ8dq4KScGYgFBT9G+
	 0nERtItuS88v7zPzNF4/zdzQcNeuouNYbBxbFgA+Ql6aKPw4J0Bow+8bNo20+VuXLgcGc
	 w9Vm5oAdzPEDdbOp7KrboTFkcZNl7GTnnGerePcwBfx8MtuWtAnp9qmWo/rNYHgyyEqfw
	 nEr9x6EtRxn6fzye1KamGsY6Xku81AYSXE0xj5Yir8vuFRDuSlL8N4KEixsBwfetuyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=a8pbZ468;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5FA606A31A
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 17:55:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E5FA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=a8pbZ468
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1a3c08d6928so295693c88.0
        for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 10:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793037353; x=1793642153; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4+gIplI1IodfSwpuILgTs5fvrOniSHigUSugOeDsgyA=;
        b=a8pbZ468UZ49vcr63JufrVNGe2cS0yFk60DVs5WdIOK80Mb7s7wh/162Goo+pfPiTi
         R3k6VbRfLrkHTrUqpjmkT8qvOgolCOCoNMgMIbFaRnRn7ZOtaL1BmiXcmM38CRSZ3wj8
         xNo/vxm+ijNqwBliORBi9K5YXF74No8qzEGdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793037353; x=1793642153;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4+gIplI1IodfSwpuILgTs5fvrOniSHigUSugOeDsgyA=;
        b=SfHvVM2g/UoeYJ/nORocI/d+iqncaIb7ShldjZUMnkVvBE2M1bDgZ0DuuMFIxF1Khj
         4F8rKv+FJHbTu9wZdPDgHAfVK8byS+HCiiQ6qP3t4pRPStd2CFo5wPy0tUGU7+C2NPIH
         rjkJi9Adtc6LvXpvHTFoMZnBoQch8u4J7pogk5rgc10pEz0s6eXdSLt2WoNZLy+cdgft
         Kve1tX2YJ2moQ9klVzYwL2q723v5ov1PjonQ4hZkEun6Bgp6QYKYKgsFxijK0GVl3ADA
         ox1MLR2rh/gS0XNdwq8TsEzT9z4fOvDjjJx8ZbbCArR7oeIZu6Kb2vadi8lGwmGyyg97
         Rwkg==
X-Gm-Message-State: AFq9FYIopaKiWgZwkJoDsmfSbMXIYaP2/WjOd/TwaAmknJWvmfJfpnco
	imv6nM/JnrJwSVu11NPAE0/wyj0yx2kojCpOhrg9VlK28nDlOnj/KgEZf+jkhDKWvg==
X-Gm-Gg: AYBFou1ivSUGRbF6R9oktZamWujJ4jic3uBRW4AujmtUaIhCaDTf9Hlkmi3LM/SfwoA
	AhNl0ZhKOpHaiE3UE90POkw4kgwnLFHBx0UnYxWalOHhzQU1vGYfNRq0tVxkiJa45fYztUgF5zu
	2Tt45+zvSUTsV/M5P/UKkA4s4RejAINOdsP1nCR+J1cX2kzMcQE5AA8MSFzVH5vBSpBV30bZCXW
	R45W5gKPoSUrMBd6tAKwqMoo9DmeT4EFcOBEDTuMiloNwXH2WCktrqvDyUH09s5lZbKTNIQhjRH
	zQmp2Ay8y0lbtQZr1qJkWk9WA9uL9jLIV0waiUcQX1SGSAxfvjLh1sMWO5rIDak91BXpeIZGC7I
	VtS3mABeca/wnP83fxBuaN5nbv/QjxHr9+dKtymmmjYB/AYSKelDRHvHp6pZNoFfTTQpEjq4y7E
	3RW4ALKMadDjVxodqtt7K+/aaNP0MNO+2PYnVaW/S9QN34ustneSLcqaXgqqjky6nIAGckE87Cn
	/RUA0OYsNHYOBEnxlMRhnPWDjV1BIj5oqkPD5Knc0RmY4wlDaog3L1ZSBee/VLmhQ0otZnkdwIz
	PjuaK0FvuR43T7i1jGiqSKVjPjZkK2blRpAGJW0c
X-Received: by 2002:a05:7022:4387:b0:1a1:8974:593f with SMTP id a92af1059eb24-1a1897459a7mr4462445c88.30.1793037352750;
        Mon, 26 Oct 2026 10:55:52 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:79c5:9cd3:db14:7468])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-198a0f83cedsm32549008c88.13.2026.10.26.10.55.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 10:55:52 -0700 (PDT)
Date: Mon, 26 Oct 2026 10:55:50 -0700
From: Brian Norris <briannorris@chromium.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH] iio: light: pa12203001: Use guard() to simplify lock
 handling.
Message-ID: <at-UJltNE3kU5MjB@google.com>
References: <20261026010803.973666-1-jic23@kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026010803.973666-1-jic23@kernel.org>

On Mon, Oct 26, 2026 at 01:08:03AM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> 
> It became apparent in reviewing [1] that the use of guard() would
> remove some ugly error paths.
> 
> Link: https://lore.kernel.org/all/20261021165858.v2.14.I501510b542691f595de1e110cfe35632a5fa7768@changeid/ #[1]
> Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Reviewed-by: Brian Norris <briannorris@chromium.org>
