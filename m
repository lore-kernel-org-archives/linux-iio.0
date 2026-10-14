Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3884E323D
	for <linux-iio@vger.kernel.org>; Wed, 14 Oct 2026 09:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791971780; cv=pass; b=P/WJiqDwjbDqRARocISD1+/lAJgnX/divknKy0XVODUm1zygDUbT7bQ+SYnIXwds/esMWweUimwNjwfScC4GaulfRUYzcT5B+eIilAZikNgCGlNg+Y1oNRICKcClIDv7E4HoKbaiBjDv9jzp3rDgJGzIgBPsQxX3gIsO61Rc2nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791971780; c=relaxed/simple;
	bh=ZPg3IVURet1hbZoryf1JRpqlHNpUVFH6kLrlECLl2SU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JhTKUPVqEo6Te4JqbYLR5HfconTqsdy64iht1GUOOc5DbU9hERJv3aN7srQKetBIVTwp4A5LlARUA/MIBEMJuECg+rj8Vw6IGdRrWVLHIRbzYFFoLZDUs08NzvqUg0qdqv4Ee6EyoJJkvO722AZli8cTcuKUCS1qvZ23mp94cQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2mmc9BF; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2mmc9BF"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5ba3ec92031so4035384e87.2
        for <linux-iio@vger.kernel.org>; Wed, 14 Oct 2026 02:56:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791971776; cv=none;
        d=google.com; s=arc-20260327;
        b=lS4BZ27KyIPZLXjTdBtgga6PMu3yd93V1NMJsjK6ZuJgf9m9YxNfUGTMHzvZKvmyMP
         cqz0HvgGA5w8m4MO8/qmUT9hIZHjchtD5T+nbDfeOVZ+zx+hMccr1+sFzEBvNaX5CwHw
         2QwbLS0CK09i2+SqqP6bXZv0yEn6GzziB4jLBJ9LQ1v7V+atvcmYr3z6S2bP/we7LJoh
         UW8UMsY2Iw80KAyCo/SHc43f4tiln6mvU03jMo58zOKtfMH7xMIBHZ3JiCH38XH4f3Sl
         S8JSY5kxZWmPduBw5XQFQ1AWmY0r088TuuwRTeJap4TIM4Na3xilfquz7ZKoiDeezG3g
         8t3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ga/xxKIasDCJixgw10gLPhVlkRHWXaXqkLdNz27TQ6M=;
        fh=XgG88VQIj3CYFyzQC9emF4y11pQp1v9iwTDnRRSVFBo=;
        b=YOsTL0Dp0oz1WAhOB5uot8whA+nPS/qoHC4qdrtY+FbCwUbgL8Db1/9g1H91Pvgoye
         TOIb5jgJ/P/UShnksv4XYKzlN9A1p+XbKLj9++AUj9eg5ebb6su2dx69++KG3qJET7+Y
         G4vvLkrL4i3zGPpSjyTOnQ2f3YHSiCr33LliiWikAiLpCTL7qT+cpimQtDjt3CaAjjpa
         P1Ta2BviD5I/7PVXdUP2W8DGdLV998bmwaCxWmehJtEPgAJ7SGdyf4Oo3N1Y82A5QRUn
         PxVX/qJje2MV0Q08umjH10SNzOH48LksAKTPCSfDicbxM9CoOuM/Zc6wx01R11UrLd/7
         YCPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791971776; x=1792576576; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ga/xxKIasDCJixgw10gLPhVlkRHWXaXqkLdNz27TQ6M=;
        b=h2mmc9BFuXYofgciMzn2WNk6QMC/HV57UsdodCpacrDQs7hqx7xq+wdoIjAZy+PAkM
         3RRfIMDJqRJCMxKMC0f9xLH2WW7kS/XRUekxfZljDLCWEFjCUD07iBgdqJTLqj2UW6iZ
         Zu68Bo58orOBJLvcqOLe0DYFMNZjgObFs3SRegTSjOJUxMoWWvMMZteDPQIUQDhQL0ai
         mHywsImbKmDXLrDGd+ITn65d7OdbAkqrpEK1rcXLIosJm3gXcVL3o2jc3aHe4f8xOxNf
         JVZWEsJ4ZwXJahZRZG5ghF7AQTH9hpB6K6GqSnycx/yz5dDYwT7KNcPqYsRvtaDYwQO9
         LJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791971776; x=1792576576;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ga/xxKIasDCJixgw10gLPhVlkRHWXaXqkLdNz27TQ6M=;
        b=sbUEf/+Uobr79K87Fx34e4N3+2UIYy7hxFe7+HWmceQPh4wezam2GLhNdLKL8cb+3M
         6KA0it7QjEiS2Z5xt+EgKgjBZWPHGvihq1Awds4FxvRRhR64d1o330NQ2fzt63DTuM/h
         +2ClIzVKoEJhB/qvj9Pl2tnl/K75x43JQ3BxrtrSGDG1c9njfRVntXLYBN9A5TrhKTnj
         m7FVSSm+pJ6C1p2LXNzgcxN9VBEiYkjjEPSL3kbiJVnX/9SlxzY22V7EUjDHBWJOV/A9
         /IDophWneufiy32vjhWo+2ZjGWpEk80hvkYPpQDxledOGrNHRU3A+Oa+y+6yWYBH56uF
         V/Ng==
X-Forwarded-Encrypted: i=1; AKwUvBwoncYz6Ly2PZAyYBfOwbWIaUE2SOTphQaTtN8/lp9AJVKnVHU00Dl4/lsyIncTxqQL4U4qDyYk5ng=@vger.kernel.org
X-Gm-Message-State: AFq9FYITXvC8s3wgEPxzP2UIVSQsD+JTUVz0C0T6wyoh+aZ1h+EEPjQc
	79UXU4O+QxQZqmmh/mIxI0KkU8f4tRdNsqKK5W0H6Eoqsj3OlKb5AXPbtbhBANMsf2xrVPEHzEx
	NL3cZi/O6nspTCOnn84gJN6l84IEMJ3w=
X-Gm-Gg: AYBFou3JTaGQJU8zeqQYRalVB7Uez2w5DvCxQUnsCdsUiPM6nSkxzwc8Lv7mw4bHBHC
	CWxoOWcka79KJ9wd8I10B1nueOi1Lb8o+m+M/eEHjvpZAgtY+vplP7Tyjy3xY913L31EgnseieQ
	Pu1Qg0gJPut8S1NgucpiQlI4GwzVdc7lGtQKKMOsm02VYqhx3k/iJCJU0IBrCEe8MUEIblR8PJU
	6vloYWxTnnQKmhOAffd8N/uzlQFQd4xHR4mdYyZltWCKkWZaYdgsmV6Bm5NKUsrekYOZLByqsqK
	YP+QfTqE4RkJijvxI2jYlF8v+gvtmfDcrOMV9R4rh7xe0FeRdQ57m3q3bZ+SAF2F0QyYos17H+o
	gq9mnJ2m6RxQ06PR+QMPd2cuWjEs331KCUkiWeQ4SYJsgDeanAi1IIEc=
X-Received: by 2002:a05:6512:308b:b0:5bc:b962:cdea with SMTP id
 2adb3069b0e04-5bcde5aab48mr6105374e87.42.1791971775882; Wed, 14 Oct 2026
 02:56:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013112124.1878296-1-paulius.zaleckas@gmail.com>
 <20261013112124.1878296-7-paulius.zaleckas@gmail.com> <as5jYcTlEuOzD6go@ashevche-desk.local>
In-Reply-To: <as5jYcTlEuOzD6go@ashevche-desk.local>
From: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Date: Wed, 14 Oct 2026 12:56:03 +0300
X-Gm-Features: AclHuK_CjFljdIg_AVdVw6UFxSvgyvGJDZnWdujDm8845cPvxJXAakyDfZo58g8
Message-ID: <CAPiS6wBzomvTOm3axxO7sWCxoJg0ijZOXpj_F+NNT7Woz4Loww@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] iio: pressure: dps310: add Zilltek ZTS8032 support
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
	Eddie James <eajames@linux.ibm.com>, Joel Stanley <joel@jms.id.au>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rupesh Majhi <zoone.rupert@gmail.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 7:59=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> >   * https://www.infineon.com/dgdl/?fileId=3D5546d462576f34750157750826c=
42242
> >   *
> > + * The Zilltek ZTS8032 is register compatible, with two more pressure
> > + * calibration coefficients (c31, c40) and temperature calibrated agai=
nst
> > + * the internal sensor.
>
> Any datasheet link?

Sorry, AFAIK there is no public datasheet.
If you need, maybe I can make some screenshot of relevant info from it
just for you.
Thanks for the review!
