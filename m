Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6F74E4323
	for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2026 12:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789732924; cv=pass; b=U+SX2O+dSw6twYLHIB/uXeCbSbOfeGIutqUjPXie3pBNbUwQBAlbQFIURs1HGIg2rNA/CW5GWFSNDEXMqn1M0xcIgqIky6Va+AXQI3D03yllX+zaQJa75wFUkz/1/DxS6hFl2VXTVi5fnhQv5HZ5fWU1IimtSQY1TjzE4A78yEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789732924; c=relaxed/simple;
	bh=6ayaWbsmcz83d0RD1dqGD3+lcx2KhLYJ1JU2hHA60YM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FVVF4wiwCqQ8t1U/OCWcy0qxFjn3OzgpXhHjirwUKIQuf8JO3YOIyMJUYmMaepYx1XjRFP4tZbR1G8rHrXEPXJnI7eJ0+79V0vIKf3CmAlBNRNSc43ltRmPUP0mgFABKnDZ4s2ck3CO/7lqB+T1ziGlynRE2xftI2Ep1Q7w5lSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HU1DyoUA; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HU1DyoUA"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb76798a2so2755741cf.1
        for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2026 05:02:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789732922; cv=none;
        d=google.com; s=arc-20260327;
        b=m0KbFvbS2fHIxkiHaAapoZa6aRts2TE8Uj2Cw3HvW4V3HFW3JyGFTfRHV/0GvANVkd
         tz8oEtvaI4/TTEoGpFBlchqxW1+dtmxoO9a2hE6vgGxKk57bn8loUEVIB3tHw2EHyCVl
         kGpiW0Ou1+wtzAOf7pCmqP/MXSJiMg6O3YM040pXwb+HrKJ4VWzFHtxkLF75iYjNxy6u
         bv2EcnB11oJU6fXojpeNxZThqe4l0lcnNcQHZtGf+IDVSsB9Izp8WoKS4ewuUtTuv6zG
         Ka15uCrvQ8y8VAvi1BeCL8dT0HFbnbp6qKAYVP6AyCRmL7Af7+DeBwChQc1yj9H8NDRG
         oFuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6ayaWbsmcz83d0RD1dqGD3+lcx2KhLYJ1JU2hHA60YM=;
        fh=WjZ5te7qyxiMdK2VLZkZQq/KJLoKYCBaV3OmJpF5Ymg=;
        b=rrUD68tZ0H/vEzaOEGxmq0JNv0TS6jJOjh9WbF6fThVhRe/PWR8ow1FmPeLWIMxAoJ
         +jgyK3gTcnaWP6WPHoVYveRqSj/DGp976jMzMJ5ejEbk9Aqor4jNArqIzyNIDEptJGzY
         fdC70Zx9fHanXdZ0qvFvYv9acbqwSJb4PuEq0w+nfjOM0WZ8IwdpvmX8FoYT9/j8kXi8
         F/n3nuQdSMZQ8qyGs5USLJ2Y6uwzNmEzRyA9mfLYLDxsWHSqX9HtCXVNeB74ZfHHXbLq
         A/8MbI/Xv19NzZUjDKTDWe7ENpFDk+SUkXQbSii+gYJyxVyr2YEaXnd3KKDcycPEcXXJ
         asWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789732922; x=1790337722; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6ayaWbsmcz83d0RD1dqGD3+lcx2KhLYJ1JU2hHA60YM=;
        b=HU1DyoUA7W3ZObi2Xqt9/2fae8wZ7EEnYH+PQWyTnRYjXhp7IW+ZNKKpYuiJr76b5D
         PyeFLJ/g829YoI4RD6A8FdQ3piPTlDr9QFaLLbQ35IWhcQDEzZ34hz+nsXvtOT0IvcKV
         3JEPAt+XZ/5oCvDsLOLywp9dZ3t4L1Swq3smkgbSH3rOth1rjI2GaS2JNNUjpVBYYrX7
         /4Vm8Z6QrcMGGPftPU5CYO6YBqW3+pf1ZjasctfHTjleDSZh5UrOaDecldkPuTVHVOr4
         gVKVQ6kCf9mLp/l0mZBffjR1Q0SqfsUT2Y1qjsHzQ9IByQN3wUYVCp4QHr3p4nBtQaAv
         b/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789732922; x=1790337722;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6ayaWbsmcz83d0RD1dqGD3+lcx2KhLYJ1JU2hHA60YM=;
        b=HbTFYxtvnlOCaorQHJJY9FXpBItKqWJv9O+xdlhQkmtMt/iZdZzg79CDH7gjdnzfHe
         41ezprLd2iEgbEL4C9oUPgnxyLcn4zZ5jXc7DNNkQAcAFlQrqAbYYzw2414G0XJlF/pi
         GAdM2v0MYPNnYHUyuJmb+IogeQd+NAEfle6/zJIlkqGGeLvhhylBFw2Ryz4DofVoiAqX
         pnDpcSHy3ULKbrmmrGdJouox2hZy3rDaZBk/akcZBsVVMdMcf7G6ysXTODCKEu44c1YI
         qI9RLGLQT/DxOxvqLHwb/PexZHpODNN50GgVYot6r4dXqlNEpHA6rUNp6YWowsdA0K87
         /bXw==
X-Forwarded-Encrypted: i=1; AKwUvByDnuANN9PUqzHY+h9Db749f7LS5HT2i+Ui32mkFiaMinPMswTVn8MlyGl9pqrDVqLpSj4tuC5XZ2M=@vger.kernel.org
X-Gm-Message-State: AFuF++lpXq2cRJ6OowoAwfkc8GzJXWvCX0hF2zjehEhLXsgt52189lJD
	URX6Ov2JgqXjhqMEtNWHWEaK+tAAor5fQLoHFYuIiegTpP963Or0s31jbsN9Vcz64q8ontFZcmu
	QSx41g14+ONVselul7NuqsNqFnL3Ifpk=
X-Gm-Gg: AYBFou1OlSBfVMiH1f+K3v8iOzsGqVl89N5sVoEKP3jjoPDM5d7u2y15q1XblqoI2zG
	CT8XUktaNRpebja07e+BbaSc/G3bRSrR9X4d6iJxmX5DC1qtwzkjA9BvSBZ/onFsO99Fng4wIjk
	5uCUmuGTRbqxq3j+1H1QfSdk3f1YPkQcwzwTu5C76ocD9TCMei6vMBqSIZZuZxH7SFQOGupqLoY
	31nKoIGDxD2sHVAhXuAwoNRJH5i9gpPArtk98bpTxWAa/f26Ffa+W5OfTxDeLWlHhArrKdce2ss
	UZE3GIzhh8DIQOluEOUKLAcDL1MW2WOnbNFlOgehSCWKH/0hlcbORdGNlldkaGuwMeQI+/dnunk
	3nO3uhTruPkslCtBR2TWDFA==
X-Received: by 2002:a05:622a:244b:b0:530:ea8c:1b6c with SMTP id
 d75a77b69052e-5329e976b4amr30710831cf.29.1789732921860; Fri, 18 Sep 2026
 05:02:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917080905.7654-1-palaomer100@gmail.com> <20260918-inescapable-crafty-cat-b03a46@quoll>
In-Reply-To: <20260918-inescapable-crafty-cat-b03a46@quoll>
From: =?UTF-8?Q?=C3=96mer_PALA?= <palaomer100@gmail.com>
Date: Fri, 18 Sep 2026 15:01:33 +0300
X-Gm-Features: AcwNN1UohY9u8D1FB3Y5bUT2HvOqBkA66e9QPA1W3DSDZ76z-GyXly1_UBbtjCo
Message-ID: <CAKhZXnqGPPFFKttTCxswx2cpSJctJxAduRLZ77NEVLTk8T3xWA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: iio: accel: add adi,adis16203 support
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: nuno.sa@analog.com, Michael.Hennerich@analog.com, jic23@kernel.org, 
	dlechner@baylibre.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Bindings are not for drivers, but nevertheless you clearly did not read
> the discussions I linked in your previous post.
>
> That's staging stuff. Are you again fixing some issues only because
> checkpatch told so?
>
> Best regards,
> Krzysztof

Hi Krzysztof,

You are completely right, and I apologize for missing this. I will
drop this patch since the driver is still under staging.

Thank you for your guidance and patience.

Best regards,
Omer PALA
