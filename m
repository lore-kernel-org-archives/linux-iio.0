Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499204D487C
	for <linux-iio@vger.kernel.org>; Fri,  2 Oct 2026 15:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790954459; cv=pass; b=jGXkQ9/PtEEn7ju9nPoUEIKRhYzN5ZYpuOyk8FpySOxoxaRcE5q5jFGHGkOub96hh9B3DgbsK2XGsznMYU1qObJuNvvJuuSYMWxJiJJ+292uOP3zIQ11+SS1rDbk5vmO64h59RdQcYCc/S9vtgxUjhE1eyfjR83PPvgPtoGXDvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790954459; c=relaxed/simple;
	bh=c8Ui2uQdljkfizQJxJXTO3Y+BpS1mteN/FKkUOLbueo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n+Z6z2nYyYlIbwoDmXaWICVM6qtftjLSacdjP0sawllxN+J+gf4MnVUDbtLZndLC9mH3b6h43Q6vuBMyxOMg7Pysq5Sv91XE6QQ9vTlAxkfTmOufVWTg0ogtP8uvlc+NLbwOyqiIadKVlrWZbg/5UJ9/tEo11snJI5ENn++v/Sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcuenG35; arc=pass smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcuenG35"
Received: by mail-oo2-f39.google.com with SMTP id 006d021491bc7-6e05989a25eso4901eaf.3
        for <linux-iio@vger.kernel.org>; Fri, 02 Oct 2026 08:20:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790954454; cv=none;
        d=google.com; s=arc-20260327;
        b=S2JhDDHZA4yf40CXc3nRjvYXvn00HK+kvTus8qGYDiwZ9qyiFss9PnqbBx0ihiY8bi
         psNbPrZ1PAcNhGSN0fYBOwolUMIbwi7MUI417YtBUdvGJ2HYRnu/Ce3khbVIwq116dWU
         WMcH2FOs7Nn8nURf6l6l7uCcO/xKO7INIPdxiv9QiX3PYTTAaWXb/tYrngp50aiUtZjT
         53U5E6OU0nj4Zx+/RJe0ajMiEU159WsYP2ZblO/qfqVglvw8BQTUbGopfF4v36TLW77o
         mFUWberFZh7Uees1cXPQp8U+rnYeytbF81287qHNpyDTolrJ2fa2J5D+lNaCtXRzoOAy
         HhvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pRJcBvkIQpM6vnmBseq7C5SjURfqx9cLuKNSFbQ72co=;
        fh=k4ES4v1B4tn8gqGLwC19zsb3GAbpv5yhFVQ6EwpDrNc=;
        b=gICKbzUJZ1ip9bPvaGTyBHrXxyCEyVgo7lKHquLUhnJTJrauh1pSgFxrjREfaNQ8lW
         BweEz4f4Gwg7bcViB+xRKwdnvXnuWsE6HHT2kRti43e+Cra3b5Aa7kfgR9WC3begCWY+
         2Z93xiSiYYzXzTkyVcjNjZh0lsurBp39JvOg6Ka3HXDIviJEgXV922OktYOu+KsaLswk
         1Ld0VyWc5QWoGYi+C6xW/2dpgOtDcUBOFtlsyNf48BlBFnhXv1eK3Wr81YaflDC0TRLZ
         PcSZSje1neeHxU15J+ZSqx8kepMT3g/bsP6MBNMC525+Mk97asppKAEpmPeL0U0EeQg5
         tJxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790954454; x=1791559254; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pRJcBvkIQpM6vnmBseq7C5SjURfqx9cLuKNSFbQ72co=;
        b=mcuenG35kUyrjl8BafkSn+d1+Ad5wZZVp7QGOEkvkFNvwMrdvo7MsVOL16hsoo4xgF
         aTdQFMURiGmg/GBn1Ooff8itLCA7e7bdybwAGCsVDHZSrY8PK+UXWrBe3qq5ix5X7zW7
         orOGrvHzuhwNIjZFjV8fz+Vw8VDVTvy8cFA4yry3FTMuFzHLVPbyBMCu5XjLztNbQKsj
         CX4a7dCDVWaUeOJMJXc2D6+w3J9hgiYt2HButBBvmyckLcdeKAIF43rKjT5S/x0lO1Z9
         W0cvCjOHxYpbpsLRL2eyr7pa9PDYrqQ/BNoHKFINhmGTFb9tRfJmmopIffryiQYp4u/S
         qiZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790954454; x=1791559254;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pRJcBvkIQpM6vnmBseq7C5SjURfqx9cLuKNSFbQ72co=;
        b=Q/esSDLTRyOl2yyu7+rfVARwTYFO/DFyi8NfnnLDEnZc6eoHIQgkfMwksYs23ds+q/
         H+rXypvRDs51lgTWtAbSv0QNMlunl+rt7VYfa+wCmUotKbfiLJFCIcWy3ycoQ0xffP2i
         Pyd6KTjp0EeGX+e2Dg8c7LAhU2ZGZqgwFii0vmL8CSHRaloPlFnrIOpDDquL/JMGM2Eb
         mvSe1F73I83Z8zu5if/9vDSSBI14FHh47txr8bMORAy3Mx7ACGKuIBEanVOcRyRE0Y9Y
         aMLCOPN0DYW0DedyOuFyj1437husHnvEkeLXXJSW7EyKEBC4NXtQPvML4S+IsvqU3Bsi
         8sdw==
X-Forwarded-Encrypted: i=1; AKwUvBy5XoIIkJrN8e1x/P6j3RB12oCVuvZsVMNstiomXl+dYp6k2NvVJ/SyMyUVUiZ62SnB93kUSWjpbDE=@vger.kernel.org
X-Gm-Message-State: AFuF++lWUldQwftmrmeFS8CVaaX9Sg3HVAhyNjgfZPctcWAkd6mfGW5E
	/us3PbLPGdNf7cB91hadWi9dugEfMzUgbEpXR23Lki1m9SMyaBOsqW+koB/1qbSuPIJYKUE3sB9
	8i0+mrNY3amOM2yaSqPUcFreoLzYb/P0faiDEF7o=
X-Gm-Gg: AYBFou0CEhwjoo0mfI6W7r25+BaAfPqx3XHdIBeAgF7NJE7rhqHbw1NSGzGCs/PW06s
	STHOd9Cvp/+TA4TIxM8hzyTjj+BpZybmZst7qINf0796lvGlvMpLWpMF7tRDHMdZ9q7vpmcPqFa
	/E0dxD3oU4PYZGGdmsYY1B777UIwXlVH+7rmU441PxzirrpDja7Fo0VmhNPdEgf9v9tDR2PBxgb
	ygYuGAM4oj5rbSQGl55Jfpti8i/kAl4iINrQK8hq0BfOhunV/czBvSVE+jm96CcQZR3Oxwz5+nE
	03JJowAG1+gRmKG09tb2TEkHhtUEmw1VZSjVnKp5dTjnoEJSjNeo1zd/kDNcP+3CbNGyxuopDyj
	wvb6LLZP3Cw==
X-Received: by 2002:a05:6820:1789:b0:6df:5b31:f4b7 with SMTP id
 006d021491bc7-6df5b3205b0mr1758431eaf.88.1790954453969; Fri, 02 Oct 2026
 08:20:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADrS85612m-Hh-G4BJmOhy-y6r3Ni3kD8_GM-2QRBeWWEEZWuA@mail.gmail.com>
In-Reply-To: <CADrS85612m-Hh-G4BJmOhy-y6r3Ni3kD8_GM-2QRBeWWEEZWuA@mail.gmail.com>
From: Andrej Scek <scek.andrej@gmail.com>
Date: Fri, 2 Oct 2026 17:20:43 +0200
X-Gm-Features: AclHuK8klb-fvmewqmk7PkjTDnYTa3t-BgP_FVZnqttllQOZ5PBEMOmDlR84Ucs
Message-ID: <CADrS857iYjafXEZcHRSmeOFjrzs0DYG5Dp2PeS0n669cHBjAuQ@mail.gmail.com>
Subject: Re: [REGRESSION] amd_sfh: accelerometer broken since 6.19 ("Event
 data for report 1 was too short (15 vs 14)")
To: linux-input@vger.kernel.org
Cc: Basavaraj Natikar <basavaraj.natikar@amd.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, srinivas.pandruvada@linux.intel.com, 
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, regressions@lists.linux.dev, 
	lee@kernel.org
Content-Type: text/plain; charset="UTF-8"

Update: this looks like it is caused by

  0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing bogus memset()")

which was backported to the 6.18.y and 6.19.y stable trees on 2026-04-11.
6.18.16 predates that backport and works; 6.19.12 and 7.2.8 contain it and
fail. The AMD SFH sends 14-byte reports where the descriptor declares 15, and
those are now rejected instead of zero-padded. (This corrects my earlier note
that hid-core had no relevant changes; I had only checked v6.18..v6.19.)

The same symptom on another AMD SFH device (Legion Go S, "18 vs 14"):
https://github.com/ublue-os/bazzite/issues/5796

So AMD SFH (hid-amdsfh 1022:0001) probably needs to be covered by whatever
short-report quirk/fix is adopted for this.

#regzbot introduced: 0a3fe972a7cb

Thanks,
Andrej
