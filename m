Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9903EBF1F
	for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 13:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776864042; cv=pass; b=Pxl5ZXSeqTyL3v1JI5Kr7fzW5IZ/avZQhMQbMvmNnyD3KaOtUVZ6ho83kRdd6oCsR1TfWbIZpvwIfzFh5LsaTkmVDEeVr9hlTpstW6OQzcMtNUy551GiEkayEdpfpU74Nt0AeDg5eFWasnXepTtPkUnwbxliqfpyFP2zfALtHCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776864042; c=relaxed/simple;
	bh=+wjeIqfqElPskXZKpXQYaHAM/xf2yZoO/YfpSl8mt8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g3Wtx8ULKwPMP7TuJpDAxiTShKyMMpEcnLhww7PAq2ba4AaSY+QvkgxeYESjGCp5S06mhO2C8WgUruBk5Lcts7a/vopXU/UdGRFITacsyONixpWBStDkH60r3ayjw12vcZYuzvHQIxmtSrNzlc74xUDDkvgdJbujRxfoyXXQ89Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yk78KVFf; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yk78KVFf"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488ad135063so47713185e9.0
        for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 06:20:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776864038; cv=none;
        d=google.com; s=arc-20240605;
        b=iRRIgfyteuAv92JMr45Ik2ZQHa0sBAmWRbFbICUt54xT29//oiTCiXCvXjmFuxD9mg
         RIhC+5bVKOaV6uoewx2Cs1Qsw2Vm2DkllhJyoMbrZ8EFEGlnwSbEANS3UnbVKN+firi/
         w/iXIZWQBW2dviyZG/rYwFeEyOB1OnqsiTCuxD+KwxBUC29iyxLGEyJwonGJKbyS2adh
         KdiP0XUXqMRzpCk/H4PKu9IUtkvWkz7ne+s+3DqtybBqxuaWvtNyM0Y5NJjW+IkWHrMO
         0BAQAGhEGKZtw6MtBSN6D+leCzSelsswEZ+B901xWV2gq6pmiWXd0HfnLllAVbbCpYBV
         erxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cQz9B1hpNtjt5JlRs2zfI5fKVPFKXhoeS9Or0FnxExE=;
        fh=ekNm7/YyfcbL4LOXR2UhYpEmgA3lRFtMFwCEN6TnxNM=;
        b=OAFP6IFgvhaPzOahP6xq66WrbpEQc1IyO+IOW48qbEI+1qiH4QI3VaQkdyfwBa97Vd
         0+UT4r84BsAWfTxs1ik4njuOK7QBY+jDAwK0ZGNxJhswsDCsBF+BiaVTaM8seis6Ik6g
         YmyPrM0ndj96EUNfRtxSIVuXMC1pR54HP2qPdTFH4sICPdEoYgk10QT69FTCL9E1oP4W
         wtkf7Q8Epq2IZluZQ7xaH2PNl/DM+rxi7LI7TZopEYwO/711KgnvWnBwDOqkmvwrLCas
         vWd0bUzjhU5sEGlPPqKc1UIM3ld2TjUVBm5muItPslrszBUuX040YJtBljgxmoFPhSE2
         5zWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776864038; x=1777468838; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cQz9B1hpNtjt5JlRs2zfI5fKVPFKXhoeS9Or0FnxExE=;
        b=Yk78KVFfwzEQTfmBMqyPPSnhr+X8boPzA/QM0sCNJ4XphHlJ9yej85Mlc2R0QowuYQ
         sbRfiy4dEzW4ISD4umFQwEBw63xv5gfHfqhKDB3dG+KqEsl5XAvzpgVFvyR45cnZYjGZ
         mL9/YYJwhCmaSxNhL/Yk8loLL1edJ72q8haQVWJyZlWq2iPvI+bpmfbgfwNAgXhC1U13
         AQGfdL84oYd5zFCOJ6mvOGSgQDCpLScUKUTppd2sTYpdTzz6g1ORTBR8Ixq4YEkHxCmN
         9tVpY44VqdbDGDPK6QbBTK7aubWslZR8HleJbuexmpDR0ODQLzQAcbQiurJfj7ifTkhb
         N31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776864038; x=1777468838;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQz9B1hpNtjt5JlRs2zfI5fKVPFKXhoeS9Or0FnxExE=;
        b=VQlSxGbJn0uZ5QTf3HzkN724J7VzbXUViLLZBgRi2jccZHz8T/wS7b6XifblTIpyMQ
         2e2LeR6eM+66wzZ74281daKkAqlGJFHOBu7FoSUF5/UDRBxpQTmSm1juPWABKUO9/EeJ
         TsHEiYZY6Ys0CLuSfizD214oUOjSES7Gry0yLSCOuKccFqxnjT0Hog2Anir005IX4uZC
         b7r9YtngSN9swnONCGWVXlOSBrS5LuF3Si648poRJ/C6swUkDgbRA+7x3efIY3PWiK6c
         wcRbgjAspFsMoJLcsJFrc9x2hanG+nTe7vTLM+UmZr8+NJqEujuSvM+uF1+CSqrn0lTS
         JWHQ==
X-Forwarded-Encrypted: i=1; AFNElJ/JsEoxsaBar0/BIqNmAOobHBhTjyfyIJ8/8kZciBcV+kO+44TcPDfknaRFOttEHqoBrEB6w+TYF18=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNp5QoULhS4Pa9xfLmTwPRdVwjnHsQH2KXexh4J7r8uKP4qKEm
	rc+3uqAbuBa+t8TKNptyNsllgrat3a7VmmvjNnrR2nDJXUAGtfIt07g2dkD0nNubzRDJpK6AMDH
	AopQ55q+QGGELs37dxWuflMRRA5DDxI4=
X-Gm-Gg: AeBDieur5k/SgA0WC85Tu+kJNMykP1r+Z9dQ19NWDnLtYhcEhTR1E1tYM/qIwZaRqut
	H7V/FrrhpScjhO9piFIVyIvx5YtBHD3HWQMAx0mrDVpXpsR7dWVOGhUNq3ryKI1QlnsTLj8x4jU
	92vxrwtWd5dq13AlYah9Bg5vXUvLpOgkSFYD7Ghl4mVMhzoNvHsuAJexS1ykoNH7uXZ2tva93IF
	nuPOBg7vluLN8gI4IDQ+NXdMH5dIqOwtPjBeYLN7W+m06E1ngZrpOpQej9Lk6xTxI8WmvNrGsLp
	eCgqxmLJv9ImJMictRWo1GntMrSLtFSNUKzADb3KkzjW+ioFv7yDHsw5oHsa/f0zLuTQvcI4mmM
	58KuELsAf5ePfLjMuZCs9JyM2HJIZuq63TKoReiddY6vlxQLRvqkVO+vGXUgFgyLLKH8mgmYpDX
	B8B77BUmyDTZDQkj4o
X-Received: by 2002:a05:600c:628c:b0:48a:52d4:888c with SMTP id
 5b1f17b1804b1-48a52d48985mr147979535e9.3.1776864037644; Wed, 22 Apr 2026
 06:20:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422112207.1313-1-joshua.crofts1@gmail.com> <aejKKKD4JdxIzlk0@ashevche-desk.local>
In-Reply-To: <aejKKKD4JdxIzlk0@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 22 Apr 2026 15:20:26 +0200
X-Gm-Features: AQROBzDuXgoF7DyCdachQ6bdlvYilKxrsGw4G8rikxb9MuF5XMwaqNUWJft5W0g
Message-ID: <CALoEA-yaUTX-brKE8OZZmZbWWJ0=q+MR=kGnmicXciYZYKbQTw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] iio: magnetometer: ak8975: modernize and cleanup driver
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Apr 2026 at 15:16, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> 5 out of 6 are good, one needs a bit more as it's a new patch in this version.

Considering this is my second patch series, I'll take this as a compliment :)

> Also, wait a bit I'll send a couple more that you may incorporate in your
> series. Btw, are you familiar with `b4` tool? If not, good time to start
> playing with it.

Only a little bit, I only really do 'b4 am' on patches but I'll check
out the manual
a bit more.

-- 
Kind regards

CJD
