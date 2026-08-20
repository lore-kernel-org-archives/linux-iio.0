Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9855F47A0A4
	for <linux-iio@vger.kernel.org>; Thu, 20 Aug 2026 15:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787240280; cv=none; b=RfcBDt69QsU+ShIABOV38zneW8GHMDuIlEnfZ/oHCTv1D5fWm8s+LfLPZfII29+tK50LYhqz+SkL9Pp8mSiSBlYuMTBS2uDVoSuRZtddlbSjVCJ781ILwOlptzMHTiSY/YKeZYvLfd26UC0ze0vSAibPIR7p84amdiCR3FvDN/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787240280; c=relaxed/simple;
	bh=SoQxoLdbmjdyviQosiQTbT5uXwu+6hvszwAP4fgXAj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X8rnkEofJRE2nVO/7CAYGgtVy+qANAH9GXJEZbPeRZZIzN7HAAeLfqUMb84911xdhXqCfIThzyeX7fmCAn9Z1suJn4QivhO1FdgRyKcrRFM2Fdm+fDpRrGEUhhKBkQYGVbaT8qfleFkxCkyiqBuk3pnpOvNxHsZnf5qadct/0rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e46p+IzS; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e46p+IzS"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-930f72317a6so141356885a.3
        for <linux-iio@vger.kernel.org>; Thu, 20 Aug 2026 08:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787240277; x=1787845077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9BUJ4+/b8Y4cDYHV4mYzIjIyZ/egReanH9w2ttMKuRw=;
        b=e46p+IzSXxXi+jFfpUj6ZQa7dvKVgrEGAsNWQpJEvgJoEGcn+3DncepRroSX7uoE7Y
         nyaTqDEGrr27ysoWfEVToEQXFf7qWjAAMm49STbDbHoF++tgLJDA7IUnZdq7CeVc7iaK
         upA22/m0K3l3EUV0FwMS35eIl4LtYlm/PoB1GxXqmJ/JQk5bozI4MtWHkCx4vKuoIJg8
         B0HiF0ar7ghSspVhAvqpe7gUwAVXQ2AgPMtAof/Ldo+60Czc8ui83dB2v7dq5RsLEQZl
         PI5KO8IO1UHREAoIIDskDyFXLroFoPjnGlEw4O9JbG/vYpOuV2QsOGV1iAkPh4GxtcFZ
         Vxjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787240277; x=1787845077;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9BUJ4+/b8Y4cDYHV4mYzIjIyZ/egReanH9w2ttMKuRw=;
        b=lVaHuaJBR8r1m+lGr4tQeSdp2uCtOu3khM1rrS1nL4hX/Bgbeufj0a4KcVXx2TzS/k
         lKw0aBR5DPyY/Ru5POCVBUHDa1FHctFJE8cVVGlmZMgsbpA27IcY7tROo+DN108xEm6X
         ndAUpwVNVdLqxe7nuxYgEo4cYZ751XfstGjRsvZLi5FLf7CEA6g1u8Gd1CmOyvTO4LcZ
         HMPIwOKDdXCyuyiJ+9kr0F+Rx36xfqryND6T6LwlOCowVIFNihZemWAcPI4jnJRmuNy/
         yrMQ/WTf+RBFHGO1l9/SKoYqF+UyM77B6xNqqe6OmPXwP4+JXmiP0pWYtSU1NmY+bCPe
         zQHw==
X-Forwarded-Encrypted: i=1; AHgh+Rrqv3dpa8y0qgafGUz9O4vBziSGM/XaSnnWgU1pWGQebWh57LZO3+9TZcbHusjPzfBPI52ni9TUkLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/ZrNu8g6+nhRQgFKblm3aI00hjTAjobwtqymvLsvIY5V8qJDu
	nVbX5RNwc3VUgATYIxII5CkofBkdTNwY7ns+aWweQG81zecEhDMyl5f6
X-Gm-Gg: AR+sD11kB1W9UWiov4Fn3ZqScV2gdSmDsDZs2zy+PPffKuYt0qrXaDt3YLNFiofzsjN
	c2nHScwHEAYAtrnzbSqvc4rAIoJkt41uDwt2rji2mALMMw0MnqZhmpY6QCHSb3ShdvZvSU7DIZh
	AN7usPgez8OSNAMuyyQLZf0dCpmd3OHrI0kGrjRjZ4w9UEyDhYpmwGeR5e1mc02La25doh1GSJx
	gET0i3BuD2Mo+dnzCxYScO3XzuUfYC1wQpvpm5r5otaGEypnHL2G8SoR4TI2SCrJSnW+s7rS9yc
	jpakeDRxIXSS5pgJvWxD+x3xsC26TKTrNfH9Y9LI8zitZGADaQA3KY0pa77yRCJ6wPH5r6xAfQT
	qIezwFSZyr43PYel7ZHUPVKQOwX5ZVhQb6Yeb4J2/DlCPtPD7eWvOt2Ql10t+6//iITgmcxo+hv
	BHo8iNVXemkYIbe2Pv2os7hZIzPJbuwbLyOs7TJkri4v6Iql4gz6yFBmAHNeoMt49RIHA=
X-Received: by 2002:a05:620a:268a:b0:933:9e3:b95d with SMTP id af79cd13be357-9371e678ffamr1367982685a.43.1787240277177;
        Thu, 20 Aug 2026 08:37:57 -0700 (PDT)
Received: from localhost ([2600:4808:5693:8201:394e:8b9f:994c:b59f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93720493f40sm393716785a.1.2026.08.20.08.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 08:37:56 -0700 (PDT)
Date: Thu, 20 Aug 2026 11:37:49 -0400
From: Marco Chen <marcochen.dev@gmail.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: dan@dlrobertson.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, jagathjog1996@gmail.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v1] iio: accel: bma400: remove completed tasks from TODO
 list
Message-ID: <aocb9uU4vz4FBo4P@xiaolong>
References: <20260813150103.56350-1-marcochen.dev@gmail.com>
 <20260817161523.00001feb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817161523.00001feb@gmail.com>

On Mon, Aug 17, 2026 at 04:15:23PM +0200, Joshua Crofts wrote:

> Strange that these weren't removed in the commits that introduce said
> changes... Anyhow, not sure if this patch on its own is too much churn,
> Jonathan and the other usually prefer these to go in a series of more
> changes (i.e. if you do the power management TODO, you send this patch
> in the series). This is up to Jonathan however.

That makes sense. I will resend this patch as part of a power management
series instead of an individual patch like I did here. I have ordered
a bma400 and I am reading the kernel docs on runtime PM and other IIO
drivers on how they implement it. 

To Jonathan, do you have a preference on how the power management
series should be structured?


