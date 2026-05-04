Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147D53A3E94
	for <linux-iio@vger.kernel.org>; Mon,  4 May 2026 11:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777894124; cv=pass; b=ZVM2AHqQZ728zFiKu7hIRt8hWoIGndf8p7R3Irt6rekfrHsWyiYcbJs60+ODxbjYRrTT25iLI+S7BcMeV6AQVuhzN7TuZt1i64finegXLt2zaXQSXzZc5jJKV77jsVNAHMz6eQ1hmkJOxGCl1EW2IIzKRSKIO0yhKut3mjzMjIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777894124; c=relaxed/simple;
	bh=u1FFsR/hLI1qWNfmXJm9fuTJXV6YLwdOjrgYj1dbvyY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L80S3ETldqdFgCDIy8jdOKKJWCCM/jI992aCvqfOqTwGjXAqBaETjclgjruQ85AsL7nbIw9XH6VBQh/7YDIe7rVyWpd9gLTy7Hypiq3SR0w+QPECNqWetwH9Bi0JnlJaRDOsfG30kJaHp9s2679tWua96pvPyKWqtDjsvWI4gYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DbfQfON6; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbfQfON6"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-44ccbd3290aso1320001f8f.2
        for <linux-iio@vger.kernel.org>; Mon, 04 May 2026 04:28:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777894121; cv=none;
        d=google.com; s=arc-20240605;
        b=VuPNn3Ab05EwKI0Lo7RgJ+w+6CG71XWycatPTGlvfzvBvzToan5SxgfjitMP5DfwNE
         Lnt3gxrkDr5aTlpFUc7V+x1Xip8ccaHlrbV7XynA2GvYWEO9vPPpGD3CBUaZAnY9VoBR
         3D3+2Amo7unYH9vlMcm9+C9kIT5AXnom/Vo0gToEqC5HOip5wlZDMklH2EBQAInMF7bk
         EK04jr8BAFrqn5d08OD5RQyidHNKHnr8OcMjwb8ciqfTCOml6HC+W8VR2ymD9QDBhJge
         bEtCJ3xKG4bwHY2qi/i1dVnhwXmrkbzhYGITgGtbGACbg7haEVe5D35QrfoGQ61DXvbz
         vqrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=X4j/3tji/zHgrWk/i+xy1QjhcOqazju7SK/hvBiwtJ4=;
        fh=WHM9ZLoaAMtkl1LbeVlT2UhA3gXTDBg19I4bUQRVk2k=;
        b=iXEWcIS93OlKVHOCz5SAfeZHbtxQ3DhmE5fcF3G4UqENvDHphesKjrE45QwI/d58NU
         dsupiLhE1EYzV3H8tIi0muJR5/CEY4h1BQkEemqNJ28zqStykr5duF+zqIcMzaZjIZqa
         C0xU/ttRLco+EiEK/kqJUiO+G2yde7tLkDWQONmKjLCsybyN4Zwg4ac2en7gS00fXONS
         2sM7RypRzyvkZF53ZwzjK5BUwcJGG2XM7IV2E1NmuDd8gRTZq012KKONCOKITajCe2Aq
         V3dHy4ToDzxzBjzgmXkKO+/4eN6HCD3XFdOjQz/+1QpArrz/iUYdm0ks4e8GtVlSTyJX
         bkQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777894121; x=1778498921; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X4j/3tji/zHgrWk/i+xy1QjhcOqazju7SK/hvBiwtJ4=;
        b=DbfQfON6eO/JjLKvjfrVUq4YLKv4IuWf6RUWYa6T6NX6YqgSx6Wjdgz+glhxCTgLVV
         llfROCwZqBM6B2lBoYavFtHGFXxJrtbJiiwDYTTSVyf8q9VzqDH/ZWJUrghPJyj7ZQzF
         Odni59rhu4k7sP9kwTn/2dfWzqUDzU+IjMJHL3gLCDsslXh7BgkQjaaC9MlFiXlP9foo
         ks927YH3yBIXCiSHuHE57G0y8CJV7joJD746PqtGg3rwCgXKDuxcK3nmiDZeWuFUn38l
         UzRCKUSQ8ZnCWzoziG0dNAXwiwvnFVGYro+wVTBAvfVouRVLHmMcigogqGIYSBTi/prn
         Q+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777894121; x=1778498921;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4j/3tji/zHgrWk/i+xy1QjhcOqazju7SK/hvBiwtJ4=;
        b=MH2iEeg/ACvD5zdjqJFdpe1aAifhie4ITQ8VHu4CtoCB8Xbqw4IARrvztpZx0l4Buw
         2PVT+acvqRG57q4I9t/XqC2DOJpKoWozqZruG++yt+DggYCXSrgJ18O3/V8QwBwQzSN8
         l2zwQVB+8bzfu+uhCFQkHojHUsW64N19s6FiQMiK3fa6qSBqAxUt2eXNVXk/6nXE0Q6R
         zsCDdqtSgTtGRc9VXlwwbZBFOjtxf3akJFzJ4qScSbY6Ev7xq27Cy5r/vakr8qohtSdo
         bfYQgBqyfz/xxoI8ljopocz+QMe2JjBqMOCNaCmR1iozS6XGMsDyWyl8viHkpD2eY7rS
         wOPg==
X-Forwarded-Encrypted: i=1; AFNElJ9/54Y4/Ol0ayfBsrWM/fY0z9OXbUjQnDf00ErKhQS7jf/E9WXb6u8e0gYvCovgpQNDWuBWMZ63a/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsROJovbTgRFFBPAJC5+/OxEN7qK0yqY3/NquQID5sVtGi6zPO
	IGNPQX2HtrF327KpFD4gek4l5AK1rstErMfdfQjGMg2cLuioGfGWvBr4WO6/Gxvq6RILhQdlNd6
	qLvk5UTuR/lANgi0LvOMyLU+JFNYJVUY=
X-Gm-Gg: AeBDieuyBTTevHLA6RRBAhZ5g4f4NCwkbmwaeYj6YQwu0qcDIyRC4br0JELeL/vg9Ws
	bzqnGIyq20MYaaiY+uEgMxBRLpD3aRPbfikRk6C5mggHtgKb3gCxDSEAx2EjFuADi4EQM2eS3s0
	a2TIyYdDslsXoRl6Ywc5kJ1jWzFSulX2bJlY1H1LEtwZhwfp1/2qBt25enWgnCpdmvnHg4Ide3j
	bB00Si9bJ27xomSUpCAQyopqge1GBMjmRy7e6MOioIw9yHfPFytUCyy+gUXQx7wCqgx2dkNHJzq
	CHtILKqzR5Qq7sxa4xi467OV27gjDbqQR489hMqLOCoReA5xehVK1R9XQhAMjdu1VKlbetfYv3k
	Dw8kIr3TQhsRsnGr2JEdQ+l872g3LjMo4RUSV/HDSJFkDNoUEmfBC2rlwb01it/gcMaMRoDWiGf
	gQInS2YDP1OBkF8VUU
X-Received: by 2002:a05:6000:18a5:b0:449:e8c0:fd58 with SMTP id
 ffacd0b85a97d-44bb64ea57emr15472080f8f.27.1777894121381; Mon, 04 May 2026
 04:28:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504-magnetometer-fixes-v4-0-a291c2a7c71a@gmail.com>
 <20260504-magnetometer-fixes-v4-13-a291c2a7c71a@gmail.com> <afh_ZUFWc4bRT4zs@ashevche-desk.local>
In-Reply-To: <afh_ZUFWc4bRT4zs@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 4 May 2026 13:28:29 +0200
X-Gm-Features: AVHnY4I8jxB86S-dcrMLSGTyYOQ9oj2lQPzgg5bHSF-7bCUZXkefGgxmTyuZvHA
Message-ID: <CALoEA-ydX=S9xO6jaetfDfXt+RQRRE=24ieDy-ajjj=xt-eQaA@mail.gmail.com>
Subject: Re: [PATCH v4 13/17] iio: magnetometer: ak8975: switch to using
 managed resources
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 May 2026 at 13:13, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, May 04, 2026 at 11:48:25AM +0200, Joshua Crofts via B4 Relay wrote:
>
> > Switch the driver to use managed resources (devm_*) which simplifier
> > error handling and allows removing ak8975_remove() method from
> > the driver.
> >
> > Note, on error path we now also set mode to POWER_DOWN state which is
> > fine. Even if the device is in that mode, there is no problem to set
> > that mode again, it should be no-op.
>
> ...
>
> > +static void devm_ak8975_power_off(void *data)
> > +{
> > +     struct ak8975_data *ak = data;
> > +     struct device *dev = &ak->client->dev;
> > +
> > +     /* Only power down if currently active */
> > +     if (!pm_runtime_status_suspended(dev)) {
>
>         if (pm_runtime_status_suspended(dev))
>                 return;
>
> ?

Good point.

-- 
Kind regards

CJD
