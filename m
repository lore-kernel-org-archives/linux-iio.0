Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794149306;
	b=nOeQ9pvwDrf3743pfmQ46FYBfSuBmZHoO+A2tVKuG8Di80A2a8a0kGxSxPaDHzcyvyz0
	 ay6B8+rKPdLnQCkUl6tZy+w6tEtYDBjnETHh/CbTBdtkkfEZvo7DnaxS7U7py7ikbXUsB
	 dIaOiIs0V1C5CRfa9PlQSJho09MILAVlwGJlLOFynFZlDR65kl+p0DPJtBoMsoktV0J3F
	 Mj5YvdYI342/PCcMe+u123tlYG6NlyEHROCM1QnrP+u9MO/UT6SUex9i5dBYLA0Vmhwfz
	 wYn9vZupz5dfhzsEYXQc4F6djETbyqfUnY5bICRCEKSmQ3Y+gzgWh6uA8kk+8SfVrog==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794149306;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=72njd0xQ5iZD4pPKmsLG/N0Oqv9jSjZrxN3BfMccT4k=;
	b=T0hcZ1YAK7Rh8WyW1DpVDsDoLr1TbdgFl0LSjxsAtkQHYgaZHSBh8ADMaa3hVukaJLBw
	 eB+CcOpHlb4hYd4xbiATWzIFw7u68ZRF06JJC8qClOf51QSy1MWFI8zlshfs8a5XXcOkb
	 C12m0pAW7INRlQngHOJvCdzZS49MQm90trDCYZBihr86LS5Lz0hfY3ru5g8tYrdo4LhGk
	 a3q+mDW7qRmOX92+LWC55054aKHfFliftIMVz1C7avrcgrYrNe5IvZ/DyOBHuoaxtfW5e
	 2IAsO88sW9pl/yfJBAp1tYsuVp6mC0BtRBcjhD1mZ/NsZi6i25JbQsNy7TOeo6VFSAw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M89O7Eav;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5D5606A322
	for <linux-iio@vger.kernel.org>; Sun,  8 Nov 2026 14:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B5D5606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M89O7Eav
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so622505e9.2
        for <linux-iio@vger.kernel.org>; Sun, 08 Nov 2026 06:48:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794149304; cv=none;
        d=google.com; s=arc-20260327;
        b=kotqNwvlZa+4Ju6jAc/5S9moj17h7SEuU2mqwJnkY0MCsBQ+WlQg62wXbiVGvw2sGm
         IXsNN+jPYNNa/SCdjBJJJ5nX79BDZbqYSDeO8peto6iEtbR4oFnGPU8+yEXROqrpzzvK
         LvZ1ojD72sPgZW6YhC9hro3olGyo415a4b5f0eFSaticWrCrkbjM2H45DQ2AS7UBSoLg
         +7PUwmgYdEQkzAsN8QDOtKRofIyzCM/xJmTg8ToB142++NQVQvR9Sn9rKPzUo+IHQvKj
         HR4hsa1RKs8qlLk8qtZl+V+dkJYKj1y9ViSfDhTHe3Wl2qp7cLeSn9ZPNLvfQ3swy04Q
         eLyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=72njd0xQ5iZD4pPKmsLG/N0Oqv9jSjZrxN3BfMccT4k=;
        fh=yJNANJ5ZtD5KtFOuaDOFcCmf6zkcNF/NVa0Nqw4cx4k=;
        b=JpIH90zasXKX28559Y6EVGQShWY31XjQEMjaLfEI6zsHy2hLoFuxNw+MnWRW8RaCGF
         o1p4BgvhI2RO3cB1cDdceUynjdeFdcP5gXdsCQb/mwuKm68b39H1M9HSjISxD8IdTTp6
         q2eBR/95LvMU7HiLwITgGJGDbvWrUfmJTAMdzmEqqKTrOuBgmbPbjl1jbCU+4xJrJHeC
         YOLfeUwp0tnSRQHhtAn4/2pPmOKPagKEAASPRICoi6PrLXyCwJchD7Oy8Q9pAmhsSEZW
         T8FoR26ihK+jeIRuJhJDXojbm/fUE6VZtaBfnPR4w8ndDeUk8ktLSdwbmBnYHx3ISMso
         MhfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794149304; x=1794754104; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=72njd0xQ5iZD4pPKmsLG/N0Oqv9jSjZrxN3BfMccT4k=;
        b=M89O7Eav+NpL1KqjMFVjw5iimIbpfy/0FQfp5RsxTeLQo/jL4ljSEZt+csLG0XgNQG
         7gmTLcUa3Ox1lX+Cq+ptOazATthaTntkflV6T0LnwYHpmzkv7JBIROJfcp3grtuzuZ5o
         +xvuRc6fZ43kmkCyGHMLQcDhcZXphFCeGHi4i2+tXEOFB7lyTIu/ICjylpIPF08BEQDF
         bZFmY5k2cqcKVdQg3gdw3mcXTaS4Z0bCA2KTwChkyMQ/8XERMIcV4hXcQ3r76D7Ods36
         6KArQhsNgtsOLOEtt4ZnfwUIPNNjnjKq+Q4EgDoGy/hUCfjf+/dDa0GWJYMrgpRjXT7r
         Wt8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794149304; x=1794754104;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=72njd0xQ5iZD4pPKmsLG/N0Oqv9jSjZrxN3BfMccT4k=;
        b=RFrn8F8w75mWCBSoPix4QFR9iAOCKVPeoive18nLN4GksH8CYRPaLZm0JvlDijIkph
         hFj1E5k/oj5OcWnUuChOY7FiN3zN3zzBXAt2S3RRE0ycDYISxJcESKfJsEOF4sDBiRj2
         5K8QKujnpF4BRaOn86Mj2OLmfwKxo+w/hmeC6I8NGTNRJJDtbvT5wdMOKqPYLn18fJ3y
         m09+Yt6BxJe8S8Fdz0Y8tEU6aeCb9a1Uad98MvolPTQGgC3S6aDLRoXfoOhtmZXsSJp2
         Cg9QazPtGchu7nOG+pJk0UOgrBDieh/WtShD4twac/LmcGHniLVbNJV20JUq+z7UT5yF
         ZZsw==
X-Forwarded-Encrypted: i=1; AL+hErFaVYBphaRsoPjPTt62YhaCqiSrpDWCJPI+elrRv6AJXXqyq310bVBWGuJ2zvLfblSkb7Wfr+aH9cA=@vger.kernel.org
X-Gm-Message-State: APuU4Z859ug+Qk7GyjNAa4/EoFJZ9VzwWGEK1jCz5ruCQH7xZ5f0jrBS
	KbjKl4eMmCXJjrh14kfy4DJAgOisMG/5jBvA1MQpRbIvhGnQ0O0QcHWv3KYPkZvGFHp89gH6pQN
	VdZAKPIefJQMJAWIjyL6lbUYHYs+VW9U=
X-Gm-Gg: AYBFou2npinT7AbbM2OVmbRmKcnzuQh6UL2gmESmCWhxPUTbEMLq0jPwHEojimWbmJy
	9NXU0qiU4Ks6FHEafHKGxjjFeIjiQOU32o/ZJ1GZHvsygLJJsLQdRdvnOae1NRUXDQKCiUL5vg7
	U2Ja2M6RQZ4MNV8wnPy3RelHsVAtSZNlNUctn9nUmSNvi6b5LeDsiPT5YABf2FLKH6Gnj1QGN+s
	I/0oBPb2pWxqwJJiaeWEYRIm+JT1GYxsaww9s5JGGZIjLOpM1hLtyuxZf0AQdFPkMk5dr/KfhBu
	+vtexNrH96z+P+Eveyy4VSasDMb3FoWpnj12hS8VZ74vUYiv6LiX6Bme3JKIvM2TalAPl4zck3c
	q9ErfjiV2o+jzLLKIUmoaiHiyZHIhbl87dbLI+Ju2ClRD0sNyvOaqMZTNnIW2REJo4hE64lw=
X-Received: by 2002:a05:600c:800c:b0:4b6:267a:dd6e with SMTP id
 5b1f17b1804b1-4b963c9b704mr33733845e9.28.1794149304259; Sun, 08 Nov 2026
 06:48:24 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-tle493d-v1-2-3246e91e6394@gmail.com> <SN1PR12MB25289B6D8FD76DE3160299B5A5762@SN1PR12MB2528.namprd12.prod.outlook.com>
In-Reply-To: <SN1PR12MB25289B6D8FD76DE3160299B5A5762@SN1PR12MB2528.namprd12.prod.outlook.com>
From: Viral Patel <viral8854@gmail.com>
Date: Sun, 8 Nov 2026 20:18:12 +0530
X-Gm-Features: AclHuK8k8SGGyofgHCdVBkLXPFoEz1YfhP16T0j4rlTWnfJa_LPLI57xmzGezk0
Message-ID: <CAFkCdFzQBHMc1CvOJFQY+mtepU12UrEQfWyNdY+rWUYW5CG7tQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: magnetometer: add Infineon TLE493D-W2B6 driver
To: Victor Chernyakin <chernyakin.victor.j@outlook.com>
Cc: andy@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	dlechner@baylibre.com, jic23@kernel.org, krzk+dt@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, nuno.sa@analog.com, 
	robh@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Nov 2026 at 19:13, Victor Chernyakin wrote:
> > Based on the TLE493D-W2B6 User Manual v1.11 and Datasheet v1.2.
> >
> > Datasheet: https://www.infineon.com/assets/row/public/documents/30/49/infineon-tle493d-w2b6-datasheet-en.pdf
>
> You should link to the user manual too, since that's where most of
> the information relevant to programming the driver is.
> I see that it's not available from the Infineon website without a login,
> but it's easy to find elsewhere:
>
> https://assets.sourcengine.com/datasheets/c9ebe749-34ab-4924-ab2b-aa7d4dd15e25.pdf

Agreed, thanks. In v2 I'll link Infineon's own copy:

  Register details are from the TLE493D-W2B6 User Manual v1.11, which
  Infineon provides after a free registration:
  https://www.infineon.com/gated/infineon-tle493d-w2b6-usermanual-en_dc6d4e62-cde1-4d4b-87bb-c3368e25e35c

I'd rather use the vendor URL than a third-party mirror, which might
not stay up.

> > +/* I2C addresses selected by IICadr, i.e. the default of variants A0 to A3 */
> > +static const u8 tle493d_i2c_addrs[] = { 0x35, 0x22, 0x78, 0x44 };
>
> The manual seems to list these addresses as 0x6A, 0x44, 0xF0, 0x88 (Table 4,
> p. 14). Can you explain how you go from those values to the ones in
> the code?

Table 4 gives the addresses in 8-bit form, that is, the 7-bit address
shifted left by one with the R/W bit in bit 0. Linux uses 7-bit
addresses, so 0x6A >> 1 = 0x35, 0x44 >> 1 = 0x22, 0xF0 >> 1 = 0x78
and 0x88 >> 1 = 0x44. The hardware agrees: the driver probes my A0
part at 0x35 on a Pi 5.

I'll add that to the comment in v2.

Thanks,
Viral
