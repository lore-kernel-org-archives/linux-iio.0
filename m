Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794912119;
	b=1Dy7zUaz/W7zjDw4WdtR70EYctnR5V5dZsU22yKJYgcUd3Ih4my8m+tvO7bDxn3y6Kno
	 xv/t/AAgtFE82riyx7rc2Z0T8Pk0yPf/+X5SpeOF8xIwnk8hHNnRwVFvbyhvh+LTwbOLX
	 xq3IxIiz2AW8goSWxd9dcnW/vaMEWGs/jtmd+/bBhWo024kca6ryjk0GcqsFRdzWLuqDj
	 UrrodFHYaQfq4Pfmm4kS7efQ/GimuOAC6N7JmWrU2+kSknKPCl+gVz5Jj2bsTh8nmY+Vm
	 i4/nfnAhMKY+0aJLAECFC300Rdrjce/TAddoUZupnmScat140LylMBxT6yMrYv4YhYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794912119;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=L4KOYqWx580iSeGrUMZkCkNhUGinBxxLvt7tMIPLBDc=;
	b=F+CddJ3fpHZc7nLZZhrdzi6VU4FQtKNnEtdbBPGqxSbvO+nYVs8xvYDFo02/Gw5kJeiK
	 0TUzss2MOxmrHNL0tc7S8man89XXfgPufLm8MjVOnJ6F8yV/4Sgc0FOPwU6oKMr9jsK0N
	 iAjVjIImGiAfwLKxZGkSoyJGTbzbwkJrCSAhz6aMC5A4eFX8NED77QqlpEkSJdv5sXmBQ
	 SGlH50jaxNOCXN6WAgU24ylSit04z1bPJ7lMqLTR47zoLr/Y+DEPDJSS1EYcOaQEd4FwG
	 DVK3fEVHC2rPT5fMro6EjRoLzTtTdLYjxjNIkf/gA9uEeK46Lyi0swaWKNp2t3YnYpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VacCkSJW;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31157606A323
	for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 10:41:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31157606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VacCkSJW
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-37071c0f42aso6660331eec.0
        for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 02:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794912118; x=1795516918; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L4KOYqWx580iSeGrUMZkCkNhUGinBxxLvt7tMIPLBDc=;
        b=VacCkSJWfgrSjFRQ+4vuPBmDOU1Braf46fyBOsDxjiqANqIEAQcmoi12iwoXoyvHKj
         xK86sMaUlmdzAoQj9RTiqOyDd7VAWF0jm66tjujttFaYUxvCnEPZMGLn2uIWUvpmVmEd
         8VkwjKmu2mraZFFVLgr+IQoqbILhH1z0ll+AGzSKT4tGydnom18ohVNMuJCc6EtGxMoE
         juo3LCNGOOeohOkobAXhgyppA1yYENPvfhNNUaT5BfyHAb8/KjINurW+b6jZ31IeQA2h
         LpIR4fKOBHDWup4Bkc8p/AW6yWYGprbY1QGxpshslQ/iTkyP8BFrW4ejgmxjIj1fok4m
         UOZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794912118; x=1795516918;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L4KOYqWx580iSeGrUMZkCkNhUGinBxxLvt7tMIPLBDc=;
        b=qyDTpoP++/aySGLQlQtrSr0dwV82otvwP2rEAfA37qatUuaBPF93QqFy6neY6XvZeX
         Kt0DwnRiq0PPp6A0fiaseFSH9LhSeXse7zH5OLXcFe6Ct7W/2hq0nfIMG9DvCbyBYE62
         xNVTMTwJ3I0uEwkJRT24QjPvQ5kX8dLm18giIwYoBJiEd1IR9vnuCuW+kpllF9jKRfVG
         sLgL+RhbGAIQk+08Aypf7FhYSFygZdDIXUya0UZ+5z7Cm1XlXsdESZcLUbXmn82pizcz
         klazqnzaQbqaKw8TbSHwFoM4m9sFXt4REwQlthXE47lOkc1joHTS+eHAPigLYUfeZJ66
         cwIw==
X-Forwarded-Encrypted: i=1; AL+hErF+PfiYwVSXR1tzSoo6X4pBuK3Ku1WXXB8m+YVwsYGEezPoAo8AOyYW1D4E3voY7Ha1S/OtF21jDJM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+eFDLo1gH/K01e/V5GebxF/UKcXTXK0ThjdkTYdOX49vecNT3q
	OiGUe5Yhug8fuj9/uvJNk4LL/2HxWGqFm+KcSQtY1uIYqYh3Z52K8UWf
X-Gm-Gg: AZFdTZcnEZFGXmlUVN6/il/gUdr6U7xx+Y91YFZlWk6sq4lSCvISHv7D4uDSvnnXjOh
	U0iOoQweIL/EulI6MgURnt8RIhT6KQ7/bM/OW8KDolcxcKBB3hKO+YtLIww/eSavkxl61LDTtzi
	FGzcADYecNJrdePLkunBZqMAbRi4oMVUgsQZ/+bEgDovgQ8s7SRWjgVi86+ValPX3buZnKPXbqZ
	tsF9W72m8wqLunLS25AxBTSUCpFbgS/czAW5/ID3XEGtxkfrWnCXL5ZeD3yeyMhPc28BctehUVj
	FDyAh7h//wWXKTsvOqQ32l4gMFQNiYSje64oZvCSdiFvvOL+n+DrF8pPyevnTnrxeOaFKepooK5
	VZZ3btHXTVNbLC8NWEBy1k+tRQzrvFQ9p/ExgFU7apjRYjIPV7JS1/JHN4qxdPaLNPzk+8o8GnF
	melDgK5t0izwgQIHUYqZMlbJoScU+GVFbgcmoUGC93Cv0+Bt31jjESJosDj/V7pB3M7hms4yUMT
	FmEItHYR2q7MKdjTRjMhZbqeIpDJu5C1nuWuDbYalQ+QnFJCh6WJM+EuLq587rVmXvBu1VZTyY1
	NAq5kSZPj5NHazCZbkNX2pWsK/v2ImRMbZP94yUcG9s6wBj6wTbgdc4Hh7c0erXOzYwgks/2MOk
	diKo3xwjzIbl/XYzxaapdRHthW3UrT2wdHGvPFL7Q0A9FA9u9Sx/t9cAnvP7Qo+guiJ8maShSln
	qbpLdGyJog+jK+waGXSirA8GpQLqsd6hWFQmq6mCLD5g==
X-Received: by 2002:a05:7301:1810:b0:381:610e:4045 with SMTP id 5a478bee46e88-381610e40ebmr1507561eec.8.1794912118275;
        Tue, 17 Nov 2026 02:41:58 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955332a77sm37871973eec.4.2026.11.17.02.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 02:41:57 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Mudit Sharma <muditsharma.info@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: bh1745: fix 16-bit register accesses
Date: Tue, 17 Nov 2026 16:11:52 +0530
Message-ID: <20261117104152.137597-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <avwqtvhrxmgLe8np@ashevche-desk.local>
References: <20261116194214.45174-1-kapoorarnav43@gmail.com> <avwqtvhrxmgLe8np@ashevche-desk.local>
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

On Tue, Nov 17, 2026 at 12:21:42PM +0200, Andy Shevchenko wrote:
> On Tue, Nov 17, 2026 at 01:12:10AM +0530, Arnav Kapoor wrote:
> > - bh1745_trigger_handler() stores the raw bytes in a u16 although the
> >   scan type is IIO_CPU.
>
> I didn't get this, what's the problem here?

The handler does regmap_bulk_read(..., &value, 2) into a u16 and puts
that straight into scan.chans[], so the buffer gets the register bytes
as they come off the bus, LSB first. The channels declare
.endianness = IIO_CPU, so user space reads each sample as a native u16.
That is right on little-endian, but on big-endian every sample comes
out byte-swapped. The patch reads into an __le16 and stores
le16_to_cpu(value), so the data matches IIO_CPU on both.

I'll reword that bullet in v2 to say this directly.

> Otherwise seems legit to me.
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Thanks!

> And you also need to add
>
> asm/byteorder.h.

Will do in v2.

Thanks,
Arnav
