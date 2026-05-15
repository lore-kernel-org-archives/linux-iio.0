Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77A32652AF
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 13:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778851377; cv=pass; b=p0qsS/Jifjd+Lxk4jysis9/ZzMkY4wPMo9h0hHssZaYeR77ikYLbZM33vjE6lvTi8YdPyG4mpurknfDiTdPjtp5p3NCLy/adLkdfxt01moTVmyGuFWeOgYEsepo8dyzcA7g/4trA2Mehr6Ki0JxKdss4jqzMCMfwerl0HujutL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778851377; c=relaxed/simple;
	bh=IWo6Gf2mUr0MercCDXDBbIXoT1ZLYNzTQek2HP91B4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m3SOSJdYsV8igs7oAd76gA0ksCJDKYpus42bWrxcL72SJEO1LQErFZ0IwzPvHD2LQ+nyLYP/MvsqyDJ5Zu79gQ2+qz9nZTGxad4qm032L1XdNlLG7GNHncl0H52IfaTRKzMP8C81Bxfr/0zYLKYsl+QBrMzHgwseNl2dgJnT32A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PcLSUpe+; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PcLSUpe+"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so98370455e9.0
        for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 06:22:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778851374; cv=none;
        d=google.com; s=arc-20240605;
        b=jAg/hV+LRK4tLGX2D/T0xDyM1BWJzYu884rpQRHWYt8H3s9MHocPPQRGM6RJ19eXKl
         4eLdHn9pzfmDxzgMoPx5WOO/4TQrFBgoB1VsrgNSenIHw8SPTkHR7kTVoZ2Uzx9l5Hci
         Od6hrnQ9y+hkEhkbjUZJ3FBstbKQynzczsKxFPmofhofZLjQnyGoXkGkihxMfzbR/VbZ
         hBNKEKFqEmXJq2GaF5ov4dH2xKy6E/JPkSS0boE9uAFhZkFibt99hvzREJmNVGmJ0P1Z
         Oz7h1XdrEdc2csBUqcLJF1FnXOkldfvn932VLKXZRZqk/HNzsDboPGg+wzWrPJaHlxed
         GIEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Kczg8yvREhgmNjpIG9Wb/cydRxK/LtqKtZ+QVUqTT8Y=;
        fh=cEYFqWJcwic5o0aZlA6Spk3NFQ2ODGdfUflURzIp5vg=;
        b=KR14ib90JqeO8MJ1011TRLjDWEOBE2MIkFA9FchjnQZIRVmFQwCvZGitymTtKLtOBG
         VWEE86pHoatsimxRes7H9W1PR/duGc2AnJb5qYX0bBuAha3Wo+LC6vGEBPvo4WLddLW3
         qdYRbd+zlqnpCoKGPFiojElBnV6Pw+OMlmQyXyoS/nUXzdxghuJ4mqGPvl6TLJV0LbTt
         /OM3ig2ztUNUCYRRkUo/NKtF7aBbReNY8l62OEhvvUoSGHIG7EDZC4Kbn/3EfC2M9plV
         w01UiRoliHgVkKjKPaW1iG/78oOBiYjazbWlpJGPsBA0mBdfCO9605KwwUVCC+03BbXi
         By/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778851374; x=1779456174; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Kczg8yvREhgmNjpIG9Wb/cydRxK/LtqKtZ+QVUqTT8Y=;
        b=PcLSUpe+npLk3ScMbL2PNslkTTMHVRjPeMruJUlQ2pqxCghiDZXtoJfceKw4P+yoTG
         9V2/ymH4I5GMQ5OPns6DaOnIWHMrj2S6Tq8lnuJ/vjOaEK0APpOqfRxmORLv2Ao8pRZi
         x397C8tLaUViiI+hleEkSEe/JA+4+FCYzuPUV6NLcCY49bHF4mrL+zRl3CJbIclzmJEq
         b1wzn36rhODXmF8IGYbmUVrjZDKqxkK3tV60aHscfOskddLRwpe/ZHI+vSwGz9+mBNah
         FlrVe2VwlLf8hF9YWEqzVugFaAUFTgFRXAhHOmydoRMk2SKj/nuZlMfXdxeyOLCKQMEL
         GYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778851374; x=1779456174;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kczg8yvREhgmNjpIG9Wb/cydRxK/LtqKtZ+QVUqTT8Y=;
        b=OAGMbfvA1sAmfp3Xrhr6+Ry+ojmozwzhBLldOxT8f/I6zK2xqglMXpJjin3egYTXtB
         r2Jg1T6C2/ahMSjvgnm88ZIhjbjZBos/QEBgIARazxHFhyYIEFZFNgFx3kTeo4m0i+tz
         SueEhfyS6asjSSJfrNWBzFu5KqBwB6xKfFV5yt5RmI4y2l7X2zixdJkfANTA+gSmNRLk
         aXYuJXqevmmXp8sZSwzbYT8Kh859EkPnAUACmOxaH6nkdK3rVo1bq+w+wxGPtG85YhCC
         Bpci9O70Udi64eg+qJh5fVJ46JAVvkHLA5Zp3YzgmZXfzV1nEwornNfru+/Kmtp+zYGY
         L1Iw==
X-Forwarded-Encrypted: i=1; AFNElJ/z2i/puh/lT3bFCLKKqhiXh3RgOUF6G+sabBTfjIn24ISeyDi08GNq/ECn0CwLYDNGRK3JP00D5tI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFg5wKz3mDpRZHNTIoTf7c35v8qjMEckfW51GwWR5g9tecxb7J
	lXNWxGsXNgy/RaLVC5a4yppOTDV/LfLLftYcKN+BPv8oct0WaFvSqv6PcMTFSNUWyrbSJalA8rV
	+kTrD9DRFHfQYr7XA3FGEqVf7uG5tVRyeRg==
X-Gm-Gg: Acq92OGP6/9iJ51yP9GFLFuORJCwQs1d69A8PTCyCdk9M0Y2CXjKhmZ72EROv8oVKWM
	s0WuECGr15GtUCaM5w54TLXhyehFQ7VFDJ3yioDPdKnbz6QDetclPsA9nPHRcCLEidOzMGzB5dr
	ZdwNjHDOF9fuuGDenyOhS2UxcplkYKta9zPTl/ROe6FSJOpj6sKjhrOvvFax0K6MxCQl8JiSKiw
	qps5piswUX3eszNmubeKN0uaICXETgon9jGH+FCBJdYjnNd5HRISOYCWHic8TfFz1I6+BY0Q2D/
	lsG6t8oVhVEMrwELhWFPBtd9GLfPBb425pt9r2PDBFSMjgaexKCPjL0hfiGa3rZ1XfFQkpJcgNL
	GBUptv/dm+AMHSQ0QkdQsTkt0TVHdmQO6IBU1E5zyBYs/pMZNFi5rVNZCgu58T3WjWGqXB7ySHc
	4Nl3R75w==
X-Received: by 2002:a05:600c:4f13:b0:485:30d4:6b9e with SMTP id
 5b1f17b1804b1-48fe6328bb7mr60663425e9.21.1778851374045; Fri, 15 May 2026
 06:22:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513-ak8975-fix-v1-1-104ea605dd54@gmail.com> <20260515141723.5fbcaeca@jic23-huawei>
In-Reply-To: <20260515141723.5fbcaeca@jic23-huawei>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Fri, 15 May 2026 15:22:42 +0200
X-Gm-Features: AVHnY4J-jELMTK-0EUBhYQX59rm50m-8Z0iYN8fkQLqo2U29FcR1E6OJRg3Byms
Message-ID: <CALoEA-w+Oe1jwX+M5_sNPVaTcGOTPPhT2g3-90NNd6aamZL+UQ@mail.gmail.com>
Subject: Re: [PATCH] iio: magnetometer: ak8975: ensure device is awake for
 buffered capture
To: Jonathan Cameron <jic23@kernel.org>
Cc: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Gregor Boirie <gregor.boirie@parrot.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 May 2026 at 15:17, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Wed, 13 May 2026 16:35:52 +0200
> Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:
>
> > From: Joshua Crofts <joshua.crofts1@gmail.com>
> >
> > Currently, the ak8975_start_read_axis() can be called while the device
> > is autosuspended, causing two issues:
> >
> > 1. I2C transfers in the aforementioned function will fail or timeout
> > because ak8975_runtime_suspend() disables the device regulators.
> > 2. Since ak8975_fill_buffer() does not hold runtime references,
> > ak8975_runtime_suspend() can run concurrently, and since PM callbacks
> > do not use a locking mechanism, it may cause a race accessing the
> > control register via the I2C bus.
> >
> > Fix this issue by adding struct iio_buffer_setup_ops that contains
> > preenable and postdisable functions to ensure correct that device is
> > powered on when running a buffered capture.
> >
> > Fixes: bc11ca4a0b84 ("iio:magnetometer:ak8975: triggered buffer support")
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Closes: https://sashiko.dev/#/patchset/20260511-magnetometer-fixes-post-pickup-v7-0-9d910faa28b6%40gmail.com
> > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> I'm going to take this as a clear improvement but the point sashiko makes
> about turning runtime PM on only after the interfaces are exposed is possibly valid
> as a general comment.  It applies to all the other paths though, not just
> the buffered capture.
>
> I believe we are actually fine here because the device is powered up
> at that point (the set_active making that clear).
>
> Open to other people's views on this though.
>
> This is another place where we really should work out a best practice
> guide / set of standard patterns to use.
>
> Anyhow, applied this one and this is one I've marked for stable.
> However given mass of stuff around this driver it'll still go the slow
> way and we may need to manually do backports.  So applied to the
> testing branch of iio.git.

Ah, I forgot to send the v2 with your Suggested-by tag. Up to you to amend
it I guess.

Thanks

-- 
Kind regards

CJD
