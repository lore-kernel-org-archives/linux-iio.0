Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D81F40D58A
	for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 04:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782793704; cv=none; b=RTdZYFl4DZmtTnh0hsQOt/vqkgMBxn8rif8ZLsksVr0ee8FZdT/BWN0txmySQK0bK50vz87+bHuesPAkMSv46vE4siCnCLFzlaAhj2t4UC89A3eE4sBNJtXJiTUzCv2A/IjgcqqVm8H57XEEtMbGV/3VIL3BcodF9vELwUveJzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782793704; c=relaxed/simple;
	bh=xJKT55bm34PbDyZKSs2QdqQluEMDHDryBLZVBk7djFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CwCUlR/pewM2bS3p6fHWQhfMPlnwcgAanInURUEsyflWW2yDCSMOiw/1C+hyPvLq5HyHbDgzh2WIzY/0dwJnaaze24DCxpPcp0czvGzOAPTkGFSiOkV0jiAzbS7OGgo97JNDtO/IdrGAtbAyGyt4L23e10CcqOXqNTWyHcLkJkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r3HZ8/9m; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r3HZ8/9m"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-37f816d01e3so2793967a91.2
        for <linux-iio@vger.kernel.org>; Mon, 29 Jun 2026 21:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782793703; x=1783398503; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xJKT55bm34PbDyZKSs2QdqQluEMDHDryBLZVBk7djFA=;
        b=r3HZ8/9msLIpgw+ISFgpy1eV2Gds6rEsI75BCnNwt5dkRCSQ5z/hfJFSc2GhrTmY5u
         dmX+uRoDYzh99D0wucNxazvWLjimWc20cVzSaYGXuyaKqd8nuwWxSQWwAgA3RZHElLMP
         SzqScWz2+QBEqVbskGY7qZuy0O6mFrExY4WqtkUtfix7DZpKRz3eK8J8zMTdFSYMb4qJ
         sW6I1byowW5bG8uIVP/gEtVEN7qegD8vkh1YjMbLCwkZoB97S98pS4f5eDvzozzco0qo
         8/3N76vgPF4+nFUqaffuNSGjxuhEOw62a9WSJCY49ZwfazXv2EadAq8QkIkoFTCGvWdf
         +/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782793703; x=1783398503;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xJKT55bm34PbDyZKSs2QdqQluEMDHDryBLZVBk7djFA=;
        b=BsoM30LQO8kjFJZ1c83KsnucxC8nx4Uv1C010vWDLNQ7Ag9HbP1q3w7JUS7LvJBWxF
         uo4tclTBMubTMuKEltihbXEyrriRpecj/SSIwAMqrYbgKG26K8rji25ntu7W2D+RY7CK
         dgpmmCvISjUBySvz2IM/ffctsqJ49QPGSCPDq7Djk61Lv4gosYsKc0mAVgSxwzwcpYYv
         hOhMf52+lDZCeVnP0IHh3f6S/06uYjhnJ9HBxf3QRyu9wjqsspk5BZvINiIsL/EcO/Ar
         mqz1FwMUgKyC+eO2k0PU1PDPlYTik0QWSuufF5vSb46+bqSKVF1kqSv27JGM1yv7YHvI
         xmNw==
X-Forwarded-Encrypted: i=1; AHgh+Rpt4Bg3o8nwUnsSdchY3RnDjyh0CzQDBueNF/XQk7u97fGhpEhD7+7jHMJyKjT/W5jmcJD+J1e6lSs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+nz5C08Gh0EfbQy48uKxLxye0I7Q8U6wAS5IpNQbdFbODxm2m
	sEbOOqNu30ZeSahGeX8LhKrTBfTyNwhBcqqP5FFdyppG8T6w2hF65xZ4
X-Gm-Gg: AfdE7ckRaLdWkzjW7M8QRX8Jy7SelPy9pO1s1MZ1yLEBod5qULStHF0j7xnUmhq/5k6
	iUCs/6b4edbtzcPJtNtM2Pea+0uB/u8BGp/nPC95ZU2doG/Wcl+fpaU0ANUNDAZAY6e2MxagYE7
	mvZZdxODRVt83yUtGYXy9V0CZguKdWzfVB9Fq02Z5PEGA/GUS94Uh3//zITO+EpvqZ84hw3ZFj+
	kIPyLgKXB8xK1SfDeqUjib+iSL2DgXX4uSZVpJLZrDzk0QF6Rztz/pfKGDgSJFclDlNvoCmwzmp
	To119YYk9HysXdpstvwIxA6dg/Av8vjHV27iGtto6im2DEXzCPQjvdXo3sP36/9GVn3HGXlNEnE
	29abx6pW6ng3O0lbvmBZUprh9pzRJmxoO2XAOSMSEaip4rTfZdR30v6Zf3Jhot7DD7WHNdJNXJ7
	arTz+hLqKQ0osHdFg157OIuBgOasKVgVgFmNr7tGav1EW8JQtDSu8/4KO3Pul3NupE
X-Received: by 2002:a17:903:291:b0:2c1:e426:70f4 with SMTP id d9443c01a7336-2ca2e71453bmr14983255ad.23.1782793702521;
        Mon, 29 Jun 2026 21:28:22 -0700 (PDT)
Received: from [172.19.1.42] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca37a70812sm5085795ad.16.2026.06.29.21.28.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 21:28:21 -0700 (PDT)
Message-ID: <7ab78656-3413-4230-8214-8cecaaf62735@gmail.com>
Date: Tue, 30 Jun 2026 12:28:19 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: adc: Add Nuvoton MA35D1 EADC driver
To: David Lechner <dlechner@baylibre.com>, jic23@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: nuno.sa@analog.com, andy@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, cwweng@nuvoton.com
References: <20260625110638.38438-1-cwweng.linux@gmail.com>
 <20260625110638.38438-3-cwweng.linux@gmail.com>
 <66ad5723-6589-473a-91da-b13e2ba90aeb@baylibre.com>
 <5e65eabd-699b-4587-bb38-d8ef5c6d2aaa@gmail.com>
 <f759ad9b-56ef-482a-9389-85ea1e3fd7d3@baylibre.com>
Content-Language: en-US
From: Chi-Wen Weng <cwweng.linux@gmail.com>
In-Reply-To: <f759ad9b-56ef-482a-9389-85ea1e3fd7d3@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi David,

Thanks for the clarification, and sorry for top-posting. I will reply
inline and trim the irrelevant context next time.

 > This is a simple/small enough driver that it would be fine to still
 > keep all of those features in v2. It would still be fine to split
 > them into separate patches, but you could still send them all as
 > a single patch series.

Understood. I will keep the driver as a single driver patch in v2, but I
will keep the features in the patch and fix the issues raised during
review instead of dropping them only to reduce the initial scope.

For v2, I will keep direct reads, differential channels and triggered
buffer support in the driver patch. DMA support will still not be used by
the driver yet, although the binding will describe the optional DMA
property as discussed in the binding review.

I will address the driver comments in v2, including:
- use regmap for register access and update_bits,
- add optional vref-supply handling and avoid forcing the external
   reference path unconditionally,
- add IIO_CHAN_INFO_SCALE based on the selected reference source,
- handle differential channels with the proper hardware constraints and
   signed output handling,
- fix the buffered scan sequencing so samples are read only after the
   requested scan has completed,
- avoid an unpaced software re-triggering loop,
- use IIO_DECLARE_BUFFER_WITH_TS() for the scan buffer,
- use the new scan_type.format field,
- drop datasheet_name,
- use device_for_each_child_node_scoped(),
- use devm_mutex_init(),
- remove the unused struct device pointer and other cleanup items.

Thanks,
Chi-Wen

