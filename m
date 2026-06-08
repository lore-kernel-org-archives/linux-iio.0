Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F8925782A
	for <linux-iio@vger.kernel.org>; Mon,  8 Jun 2026 06:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780901159; cv=pass; b=tpsuASnFOMJ5VxU7EWnXhe3+alDt51iut1fVcd286/jy1y37e4W8ajJu1vdec7dpA8EKRth1U2QsS9Sfjb9rvdoHdEVUUHJ9CDLLvQC6Q8Rat9Gy6S8DTqpraSyvLj7Vtc2zJaFH/w7pTFl6994qKlrva+QF5bayp9KdvDcBiBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780901159; c=relaxed/simple;
	bh=bHfy37nuhXXv2KjsVSnDnRxsko7sG7MprYZCmzSFsb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MTo+lbF0Iwr+ehUkO/rL1QAsRptzTf0DB8yptJyshcl5Y8CqRcoSpc96ikGwo5LJD6ecXfnQ/TWYYDwTmHd5ov9VI/yqghfJUFKhJuCC9PU3pISbLd8fvEDYi47r6mjUizmzos4NWdcDbwYmf3mlHbWAr/xEABmBjK15n5lv9Iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LqLN9oex; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqLN9oex"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490be29c1c5so49794175e9.2
        for <linux-iio@vger.kernel.org>; Sun, 07 Jun 2026 23:45:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780901157; cv=none;
        d=google.com; s=arc-20240605;
        b=i67L2P3dMe6zcFfdjVkuLJTcC2vR5epdGQFd9yE+FvU0134Yeem8Z7dkQRfBfgnQCp
         zakL6sMHj0GQesadeYd9Fo5SqlQeOYEf1bTnWUi0wdxoGDy62IpEMNlzoEojBShZZvDN
         uuMKWeAOwop/EWMmOyRGKRERxfczbRY4xK2ZafdjoCTikhb0BcXv4OM21YZNkTs1x3Sk
         KyYVmIH4EfSgCaW/jWtX4fU84LRtlXwEUmJz1YFEViF8Wnt9v2K5pAzH9ozoINUR+KWY
         rj8IY9UMG+1CfVbo+ub+wSTFEni+jY+Ol0ruodZRCZlCUWQHaN+Ib3qwjhUqfWg2W9QV
         RSpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4jugU81pr+f1VJLNxBDFshudd8rMntDvqBLDpTS6168=;
        fh=aY4WD0+Sk58Cus5m768wrUgk3BgX8E6lSNAph5OmG9Q=;
        b=BviMmX382YSZszzPCNV+EntaYH6kCBdYYZ1yzAL9peHrsJEoD9BvCS9WnWtThpdrq1
         mrbQIce+e9ochPwiHe9nXAeCtHgNV4MH2ciZEE5pcbNz045Ou/SJlEPwXXEInRIorUm6
         qUUP6M3KIKvge/NRNhewF66Xo0lMUPOWejSqL8ujCjCaItD83yBO+KEIAmyg+jLaOIMO
         JTrTnvDIvupsdqlKNMN7PfOK9uEp1Dgt0SEKTwpRdpAeAC9aIGRcyBuExoSiFGuviqYJ
         xG1zZxe6n5jWK1vlbVGsTsxUjBxzIG1AWhMqzpVA8eTjpF1VC865K8UuADDkxWfjgwtI
         CXIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780901157; x=1781505957; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4jugU81pr+f1VJLNxBDFshudd8rMntDvqBLDpTS6168=;
        b=LqLN9oexujn8YQcAxtBDfKFtiEXOcm2EHRqbBODcPaWkMXFwsttHxrOR9//Q2qtNGF
         z4fRnjnKFweMJxg0YANgITXLP3aVIrlvKjrEFsBA6LZ9U5b7ryRSDJMlGMmAasyORv9x
         Y8l6bFS2gp6hl1VoQz6+JG87cev4dffARZG7dkt/x8vHH4602IhwKULWi9jC85jeGhfW
         1+SYAwdh7IOd/BJL/+jxL4MOrD5nZJqjIK05moZUEFCg0Rb64qvbLjmmDkz2iIiqibmc
         WfuP3WvBNLisFyxyozUgMo5baDk7cXtT6RSHgZaIzGIIbQbhVfRRlSmlyMCbp+RZCtSV
         nsQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780901157; x=1781505957;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4jugU81pr+f1VJLNxBDFshudd8rMntDvqBLDpTS6168=;
        b=noJxAIPxFJlyX3ucAFfbSu8eNjm6b1ms1MqWiljVebnM9ZE97vjANemO4ptImssIZU
         d0q3lsy7HZIoU9rx7oau00qwzOfo/OzQ/qdMz8I6SdcQviki3fI78Wug3GasBsycyA9R
         eiuT2dQH3sYTcjircHj70BsZQEArD4nyZO4Sv7kZicNnVpnGnAGeGyaCAzkoLL3OhIzg
         a97l4Zp7k+ERRlbYKcyeCUAIb/f86Gzxeb0zEcktGhZfn11zjJcHPzpXaA+efepkhoA2
         +dukeW0H6o4kAlB+hNyFiI4xQPwabeBGw7L4uIH4J/DYIkYWs6NlB2bNCXSu4DjOQwA+
         Jzew==
X-Gm-Message-State: AOJu0Yy/igYvczixZ0sh0+NPQIqzGly0lG59x8DTSFXLmU/Ez6c53Lkc
	RAreN2tuvE9T3XsYUY8nOLgFIvMuqStEbsn9J5Jyk3qcpQ3AHur7WcbnHSLYhLaaBS2l/+RhZiz
	HI+ftrM0OPCkbd9jAwd9He5SucirH4Rk=
X-Gm-Gg: Acq92OEWvmSpdazjPyryj8/uxvaidtIR6/uPCOyJavpBE0rEbW2eGfIsGJVkJBt9g4r
	WIQI8uDJoiRgTnGb4yZS+0a5eCqC0Y9OH7gtgTjK5daYPvcejePqu48WKos83dbbvRf/6z/Xk2W
	ztY4QcaP5C0EoY0K+Hxo5U5sxO2N3I/wg0Pw5dl1K788FNYlHRGOs2jePIAAsOYSdDjRCCfC/w9
	Tkg6ywUg4LjvtX8Y+Kqqrm6F1+229DzZRbFM2PzDV26V5OFEOaLKtroemde+WLn8Rl/G8LhaTgz
	aeeCd0u4zlkW6LZtBYi56r1FcOqs8F4BLeNrJNXU6/BYB4ul1pst1M2km5bNtRNZvyxe/gNTj4t
	TzeHtbbFAioIF686F8IH5kp6P8uh040IA928sbTI/SKGOgex4gPA8W/jdQiT7oumnkQq8/A5Wu7
	+sFckE9/sDx5jhsJdS
X-Received: by 2002:a05:600c:3e0d:b0:490:b65f:8b1 with SMTP id
 5b1f17b1804b1-490c25603e4mr249321315e9.5.1780901156899; Sun, 07 Jun 2026
 23:45:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607183542.368184-1-jakubszczudlo40@gmail.com> <20260607183542.368184-3-jakubszczudlo40@gmail.com>
In-Reply-To: <20260607183542.368184-3-jakubszczudlo40@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 8 Jun 2026 08:45:46 +0200
X-Gm-Features: AVVi8Ccuuj_JhJpPWBLSUn2XjCtQzdApf74id6ladR7XTQfxeMPo7J2JOTt0IHY
Message-ID: <CALoEA-yj3hMKRa-3OpKtHKswRjddkARSBs9AnfiLNOtPiygPyw@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: adc: Update Kconfig description for TI_ADS1100
To: Jakub Szczudlo <jakubszczudlo40@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, marcelo.schmitt@analog.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	mike.looijmans@topic.nl, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jorge.marques@analog.com, 
	antoniu.miclaus@analog.com, mazziesaccount@gmail.com, 
	jishnu.prakash@oss.qualcomm.com, duje@dujemihanovic.xyz, wens@kernel.org, 
	sakari.ailus@linux.intel.com, linusw@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 7 Jun 2026 at 20:38, Jakub Szczudlo <jakubszczudlo40@gmail.com> wrote:
>
> From: jszczudlo <jakubszczudlo40@gmail.com>
>
> Add mention of ads1110 in Kconfig for TI_ADS1100
>
> Signed-off-by: jszczudlo <jakubszczudlo40@gmail.com>

Better to fold this change into the patch that adds the actual driver code,
otherwise this is unnecessary churn.

-- 
Kind regards

CJD
