Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C319138B143
	for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 07:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791877813; cv=none; b=C8aPNNWnvADnnT5qJZ8urUZSjp1401EF/a1yx0BJIpWDFE8dz901F8w5EZ5FVeEl77Q0M6Upa04Sjo/6h9acIx4dvFTeaCpoh/7rS0TcDKNM9MT0LbPVklmw9zPQapkxsgjZ3LEyYJpZ1OsEoDwY3ULYGst37po1iF7v3R8Dh+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791877813; c=relaxed/simple;
	bh=tPzArETgTWA5K30DRMtFIey7+0GzDvruUvLN0+7n9J8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dGetDqhSB4DWrYByFxtEklFoz1OIbFHOd2ln+umCZrJD/Uu3hJtzx4RhcoefBgYBW9mPhFVCXY2WLnp+T5jBz25vogQnfcigRMd6i1CQWkRr09jfH8j+cCw6hMyyH1louJwDc98Jtlyg1VldLMuzWrulCi1C/DkJi3aAC58VaPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jsVJ13Lz; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsVJ13Lz"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48b9d8055dfso2002098f8f.3
        for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 00:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791877810; x=1792482610; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yHsj5QKWGOPbdX3F7/TYXqcv688FhIr45BbI5StNbhA=;
        b=jsVJ13LzQN8CH8w1ioeo8AKBuUtZyNdJLYAvYWZVBypFFI0wh7Q5rCddoX3dqYdGp4
         GsDiKo7cjSso41SgulP8tQn2IdBQaQyD+LylHOcJF3Fybbg00TwM3cfvqyprr8T3yr1o
         3GEchXBsW56KQ/aQH1ZWdF4733VfPz8wpqpdlNPUJaL/RNqCbeHvcdAivWVEsk+AXXDb
         ChStNij2lgo2V8kEB8Zp/dPtuiqeTygxgdi4KyO/vKZEzedxowEpMa/xLpg882WACX93
         fJxn0AmwKSNAbbNTaNXLQCgWoMSkGyhjJnXaxN9Sy0I0CXrPsY3TugsriNIRUo2Glq0h
         yMOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791877810; x=1792482610;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yHsj5QKWGOPbdX3F7/TYXqcv688FhIr45BbI5StNbhA=;
        b=wTddRX9VunNHsF1+YYdijh0IfkWYHrm1Esfqtic6Gj2czqWiNXxo17cpNbiFnhWczk
         TVCAVkEx4O2Z0RBsRfxLq9I8f+ezWRtdE3WUsgzefa5e3Y3E0qfqnlf6JIKodjYjRKwj
         6Tth8eXJRAJIYod78QglpoBVQayhsg+jNhl27yEb8HZPTKSxOZBo32W6kUaaF7AHWI47
         zEIBneIAVK/3+F1gHaZGptI9E9w1xle/mJ2+iCUwDUJFUoCHjCz7COlEZh3ujg2TwTjE
         3GqCE5vdWz4Nh4sy5/mh4dXFBiEnuswGMTmcFI0yCJpAjX+dONQb7vRf42/EZ0BPUIN5
         RjPA==
X-Forwarded-Encrypted: i=1; AKwUvByzkV0Menn1p2mHdek0vLIBehoI0hb3B0E4bveACnt828AI83G+1cXD1uaAmxr+wZdmzKW4XtYroW8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLiLMYMz2D0nvdizp7AArD8k1Ek4kS+fJqm+TDz1PM9c1SAGUp7
	WmMubyHE/sCL/B7KB2j6qEZadpzLJttFCQg7IaqjZoyTnv4eXURmtxvH
X-Gm-Gg: AYBFou3lF1ZNcjURtTRLalvXWG2sgjZdDKmQWohZjfyXVCQZWvbm4vMrUgiCf7q7PZr
	W6nsACRfSjgK7yrdvsO1J1Kx+7lGe7o67gziqPYC8ql3lCto2UmtcNCJ396EgtEqAQ0qpK4JIdu
	IPq7K+CNs2IULeoDBSZ8p+7zZCwFDWRC3yoyckn/c/QPSAVejdffpxspEHd9/hHyBEmThKaTxqj
	60BPvYRt6OQt3nm15ER5ijvL26K+n6RWdVJNEwA6ebvKjRA49L+OP0VMdiEkFYcr5jimyVYguZW
	9q02O1NBTw0+RfabS67GeUrCvtshVOLxoMJHprtiFHdJXYw1eXfkP8tOU3s7HxS3/TgFmGK8jX3
	An/8Mmb4tQl6yOOClHJ/JjVjtdSv/B5TADjMaAXJZjc3YKbRQYnb3cQeYwmF7JDscLebKMyvgf2
	OxqGDTlLgEYS3uWPkhLDaXVNXRKCERMvSRVKj8TxknYyl15UKiQ/JKwdezZf03x3IBKTPtCP064
	RLlg9HyjD+QspY9YAUOD+i/lpcmteHx4XBopn4MuFyH94a9Vhi6Bm8v5fj28OrT7VZIViUaQr4u
	zVrXfzPy7NFBEB5gcLHAMFBrl/x3tRFCqr5q7EtZ3TYRsAgQ5JI9QWqr5N/76HSYfRjcm8rEVRE
	xXAI8ArOXH3teBS3T3UDpnEBR0wJTGjLfyYcoEejt2GmdPDwhHidndyjPteIYVdCTfIozULuFR1
	5pylrw
X-Received: by 2002:a05:600c:a01:b0:49f:ce72:e931 with SMTP id 5b1f17b1804b1-4a18e4fe3e1mr244984045e9.35.1791877809809;
        Tue, 13 Oct 2026 00:50:09 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0aaaa05sm3203538f8f.13.2026.10.13.00.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 00:50:09 -0700 (PDT)
Date: Tue, 13 Oct 2026 09:50:07 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: raffaele.tranfaglia@gmail.com, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Andy Shevchenko <andy@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux@analog.com, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: addac: adt7316: use dev_err_probe() for
 ldac GPIO
Message-ID: <20261013095007.000052ae@gmail.com>
In-Reply-To: <as1Q-au8dpp9YFeG@ashevche-desk.local>
References: <20261011-adt7316-dev-err-probe-v1-1-27a4a8ac74f3@gmail.com>
	<as1Q-au8dpp9YFeG@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Oct 2026 00:28:25 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sun, Oct 11, 2026 at 07:56:22PM +0100, Raffaele Tranfaglia via B4 Relay wrote:
> 
> > Use dev_err_probe() when requesting the ldac GPIO fails. This
> > avoids logging an error when the GPIO controller is not ready yet
> > and the request returns -EPROBE_DEFER, and records the deferral
> > reason. It also simplifies the error path.  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> Although not sure if we need a Fixes tag as it might be an annoying (but quite
> rare) case of flooding in the dmesg.

AFAIC this is a cleanup rather than a fix. dev_err_probe() conversions
don't add Fixes tags.

-- 
Kind regards,
Joshua Crofts
