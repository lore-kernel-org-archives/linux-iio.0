Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28D5403AE2
	for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 21:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784843916; cv=none; b=VbyA75NBwVhzLXPeGS/DXYQK9fVxh4wBMKdQ7uXjPb+jHMpCveFEeO9Aq7UlVoDdjOIkAKC2HRmu0pfta+3KUJTeon+Ts7U3Leca46V2v1rzoxSmdfSPX9HkjaSc1rgKT4m9Y+dU59XR7Wh4Gc/d9ZTFsvCeAXTcG5loyJqBsJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784843916; c=relaxed/simple;
	bh=6f79sbA5nfTpY98bqD9k4KCZXyJjapdhSkgU3+eBOmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohbOd/WhIl+hayogVYbQN/deqfW1WWbmGdswBhMJ0HXr1pjd3FvQaQgob4LyRoXT3pR62b6+ju/95TzUXOz1qUIySjraBTLYY2Zljvbr2yW+Mt4SzDn32sXgfuOq7mrxDdNtYD/7LJAkOXQNLk8snauwxrzbW6Ov6x1UNxUDNrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MpEftS63; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpEftS63"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84864086bfeso1130946b3a.1
        for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 14:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784843912; x=1785448712; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9+8eCFfIFOiymdCrrKAG5J0qjb2XOXmK+uwpPgsZyCM=;
        b=MpEftS63fwY7dVgpixr5ULLFvC/VFZYr8JbuOTyIr2/7ER2qONK1QoGGXGD3EnOfHl
         8Vds4llHKHXLmVNqGcAYrjlsNKCGGmM0/PJfwn1VG1Yq9HPiNMKI17kh+gJiBo2l5o6N
         p3A1kwDtKudj8U3gx8Wz1+o4oi3MXeptK1TwqMeUOM+PF9l5lyGc/EW1SXZWSADbsXII
         CRuSkHAuhLUL2OXNj1pgjBRwOdH9T4dr3HyP+eVMM2LZlv0hnMPNxZWa6L3D3Gl/izPp
         AJ2Chq3uxCs6QBqp+HZYfcQeUGe0TMfG9xkqjMf45KcxTXgZ2mjNhHcSwbWiqVgl4jIo
         SA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784843912; x=1785448712;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9+8eCFfIFOiymdCrrKAG5J0qjb2XOXmK+uwpPgsZyCM=;
        b=mMX8WB0vZiolls2OwWjOZgLuGJtgNTke0nCXjNF7o2UKlgMJAM310aKm4M6DUD2bP4
         aPJ3PsltvYiqmDQZPxXogXZ+uUoMq9ZAH4Ob/HYrljI83Q5Is3JhgPQLaVR9p9RTfHLJ
         jot0WagkvnZi++RzFyIFnHZ94DV3Ugb5KMDosxBNLHc5y9Rlnpl7DYeGGVT80V1YQ/SI
         iE55FuAX2tlVPvVh4vspJpgYzfjEYde6DW+blWMO1YBAWJ78gPlJ8iJ4YV5YRxN73Dse
         K5i2Hr1lZuyn4GpYc3ZqZLalyo5tvE0wZdnNXgMWN6TMYsRvI0zhRlsUMRfKfnugdHqh
         KIKQ==
X-Forwarded-Encrypted: i=1; AHgh+RouffNAvZ0So2HU/HhKvlZEImnRtA+sHCEYohx98321SKykmg4WSCSO+IoQ0cXwM+r6b/PKUQ9bTmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTuKBi0YrT+7rli30vS/5OMvXJUKR2ZAmUUvdx6+XLsVyU4/J3
	36mqC11D0VvbV7j3/8icTz+i7ONFM2AhliJ4GLd13Kpyu3VvTOsuXGnn
X-Gm-Gg: AR+sD130EX80wMq7Zq5Bkio1t+49kSG/aWWsV0zkVCK1QsoWWaNup6rGDtIpw0pbbCw
	ygUO0chqVd0v5AOYEayhu561Xf7PBmUWh1kSRYYWkpjKiaR/dK52Anrv9vB3oVzDfAUmkopPKdE
	n9Maz4mWEWH+cXI6UqTdwpx4CXQBnW/IgeEgXiu4vkIRl6hyO8jxeNdBvO/IEMkVtzVzv236kO6
	SHaoSoKHpmzLcJ3DEBJL41NoppTmnhCM+S4/0KXxiYxf2unXU5b8EdJrYITWB8bEUL0c9U9GUwP
	/gFP+x0EWZX6Rhg1Rj0o826/1grzV7LFTFhM8tWPhQQEgwahbab8+B4U9485dp9Z+6gzcSdQG2w
	RW86C8B2An0rOhdnprUMRKKVLRdxxxUY/8C+Q24M+pDCEv4uDxIh/euRbmAcaOISFfENOZm4d2+
	Cd2uGpgFw59ZDXMcpcxDvPqTaZbQ6G7amus1L41SADCk4Bkdbx5efV
X-Received: by 2002:a05:6a20:e291:b0:3bf:6acf:2940 with SMTP id adf61e73a8af0-3c44af77533mr5350478637.11.1784843911763;
        Thu, 23 Jul 2026 14:58:31 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:f5d:dfe5:9bb9:71ad])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e1cf8fasm24297371eec.31.2026.07.23.14.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 14:58:30 -0700 (PDT)
Date: Thu, 23 Jul 2026 14:58:25 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Eliav Farber <farbere@amazon.com>
Cc: rafael@kernel.org, tony.luck@intel.com, bp@alien8.de, 
	guohanjun@huawei.com, mchehab@kernel.org, xueshuai@linux.alibaba.com, lenb@kernel.org, 
	laurent.pinchart@ideasonboard.com, linusw@kernel.org, brgl@kernel.org, orsonzhai@gmail.com, 
	baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, hansg@kernel.org, ilpo.jarvinen@linux.intel.com, 
	W_Armin@gmx.de, ukleinek@kernel.org, fabio.m.de.francesco@linux.intel.com, 
	kaihengf@nvidia.com, ankita@nvidia.com, leitao@debian.org, 
	jason@os.amperecomputing.com, pedro.pbg@usp.br, paulmck@kernel.org, frederic@kernel.org, 
	kees@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 07/12] Input: adp5585: use
 devm_blocking_notifier_chain_register()
Message-ID: <amKOW9ILpWd7w15Q@google.com>
References: <20260723175513.39849-1-farbere@amazon.com>
 <20260723175513.39849-3-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723175513.39849-3-farbere@amazon.com>

On Thu, Jul 23, 2026 at 05:55:08PM +0000, Eliav Farber wrote:
> Replace the blocking_notifier_chain_register() +
> devm_add_action_or_reset() pattern with a single call to
> devm_blocking_notifier_chain_register(), removing the
> adp5585_keys_unreg_notifier() callback.
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Feel free to merge with the rest of the series.

Thanks.

-- 
Dmitry
