Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447BA1D6195
	for <linux-iio@vger.kernel.org>; Mon,  4 May 2026 08:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777885175; cv=pass; b=SpNQDMOvG4TjzllqLDmxgXgjpwcofKinB64Y3DMZAp4i0P92LzquO2GRDLI4F2mg2xu/LzaEqsUCWUYEghHbKHDazdJKAHcZu3e23ywR1O/ljSMcmIPxZlx/za6zlS1dQYGs7O72IQlS/2TIj/EkVX9PIjeGhA+Ilv5T3hXWUPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777885175; c=relaxed/simple;
	bh=J/7aiMY0tbpeBcbQi8tmdDHi759DL2p5vmdJKdrNb8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZjdQm9S4p5l6q0s3uBNNzDtmgZGBdeS49RB0bTyuuoZ6ukX2+L6Ib+VDHt/j+OfFljCPeAMEmkzXdFv3ek+K9xSIpngaDFGgjUsz+O3uH07IoXyUpWQwbBCAC+GyQlwxADc/iYOrRFzmxZbGYDXGcwa0+lKjcDo6BN0dnrWdd5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3Quclkv; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3Quclkv"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-44ce78ab5feso1126756f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 04 May 2026 01:59:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777885173; cv=none;
        d=google.com; s=arc-20240605;
        b=hq6Wkdm/WsrJSe7wQ+7RWzu/dtt+rNo7NLZlW02032D33Qu0gRMgCy/wWGG1dq0N/X
         eWQz1umvGqduOR+cobTyzLRCZSXlEFtTwshJen+kypoKZ9d0jcD+cea/ovMIp8aTCOos
         bDYHuIOpUzTqog+wR5bLtYHqYJpNUPkXiqCqeB7bhZk6XurLMwS4SG5DfIvqYKun19Fz
         75oombdqA29KDQzy5/HLiXgcmKMyawpQ6rjIjMTfCzMLTqX0YOJeJJbwlMwW4pVZmwdl
         YqHQojTAWaW+hdRitt9Qjf72uhHtJyLBDmvoQuvOyMU+BxpCAstEeYRgM9mQJ7P/OvSp
         7tEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Cbom8FeqsD6idoYDS0/PuEgfKrkSazp9BF+SRYpVpP4=;
        fh=3sfpMQu3eW9lEfe2AgBSf+I9jtK/D5DafDqQZNE9hq4=;
        b=dvHXEg8Hd4kGREIz+lg0h+UqVmywhmIaaOX2bVZA5rVVGruUH5PM8+bItoGDtwkVn7
         ZoKsg4mhLEEGoW4DrWKgl6ULy5SHniRdUCCvR6xwzuiilmpr6PJ68WM1oqF054+Gbzuo
         4hPdFo6Z2GwmbVRDkpoziK+5sq1BRxSrHsV4dzH6xbgsHzQNd7JA8aIAMepBwvT0YBS/
         GQKEnCCLWDq4leZ1FOYud8BtvWOcQoAWmmdoSOA008h+l6CzqbGS3dXu7UOBjYQF7S1K
         Fxwj4UjanalenONm7TJ5bdXV91DX8weMwcG66oqKzWg1lQN6q39NraEaOWsgE3fN/VW3
         Larw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777885173; x=1778489973; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cbom8FeqsD6idoYDS0/PuEgfKrkSazp9BF+SRYpVpP4=;
        b=m3QuclkvcrGoeH+Kq6X4vAk5vG7qr7LxJllfxkjIbzNxOB/SSLabF1nzV0LhK2HcJ1
         bDoFFE7wyGzSsky0Geoajgu6Ys20WBDNrB/iW3hNJ5x/15fav9AnUEDcDske/ymIOwek
         6iQTNlnfuNZgGWGkzEZvfqpDXjeGhP91alEj4LZegHXMdYGjvKUt8Dd8sDNCQNRImzi5
         qscf8mX2naEzjA0Wc4wL9UL1PYXQIoE65U7Z+7zNWYUMizTd+uer19zoWua6fK8DtsbA
         m1uiF5MTy2uVB2YzQv7kUyCZvV1RDMcz6nf3oFZXxhc8dRMvHHk/PUlAEE1mJ2CwybFA
         /vsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777885173; x=1778489973;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cbom8FeqsD6idoYDS0/PuEgfKrkSazp9BF+SRYpVpP4=;
        b=OcxuBvnJ12yQjuwGfKR/3Rm7t8t44Bf61UxnhCyvVTlBhdh2I5zJft4+r6gNhON3IB
         qbmGa/TgCNlvOEL/CvipqQhreP3riu0J3OE2FL5Xz26EYHikmsZoK2oaN3CRTEAww9WL
         7S8VEGYdDdsiUk7wXC7ozGehx7XIQP22HDXaSffyfF69VcJmTd2P9+47YFezyZIKiKm4
         JqQUtafp/7zv18IE6cJIwDo8nr1fHFex4EG7CCptwTz3QNkuY+BqyTtkTSM4L3DwGRV4
         W9LkYTnG2oWlYR51p85IkXu40I7OOBGA/PjPIwM8w6Ld4gvC1wC/V61a5j6llum+N1ey
         WWdQ==
X-Forwarded-Encrypted: i=1; AFNElJ+SfriQ6Zc1XXfcDSP9+SxDzILXvPyymST+/l0rqNOOheFGel5ll0/BLpGRKzPojv7H90A7LRfEQNE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq+S01jBlUEzA/+2iE0+5qayMCo8gX8d0RS+lV3Q7L4AstAP28
	UVM6hofq1VFK6mJIBMxwRnDwqvpGxSaoGk84MmfW8ChwgJzW0frD9g7LXIjv8ZLaj0+fs74WnxF
	ivm5vpEtLtlv4Zpik3CMGKrGyLe6CeIg=
X-Gm-Gg: AeBDies1u72/vgKcerbd9Atha4g2oao6FutZe2xRS6zKHsZYi++uLpM3/yBXR/XJOSc
	S92TTXQtL8E3e/MSDBcIO5ObEsloo1BAawR+Hsuqnw6opt5RI0d0zDonIGLm5eywAF2Vg1cnSxD
	Obf1EyIwYktSEAhvtozi3yGasUx9xQv1ZrJT3kJNCnBX0CuCg6DCKpYkImkx+9G1qPgPVQX174p
	CbEuDFi3ZoAnVHYPLDIx0Xr4WQKJO4aj7HAWHSkV9q/JR5PLaK9i7uu4bYkqg+pUP+LZHwY8mrA
	JfkKn3w+gxukqsZ2Som8pzgzrYTeNMrQGA0FsrsxGE5IaSZoKoNen+BHHVQF9kqD38jYJbQSwU4
	LECiDQhlEFPA5vgUsgtK/CrwhrGtIf2XxLmbcfaX9ssZubjoubqIyCqLj01FCaPh5uzNRkfSRbh
	nUsJKmKXMEJ188dmjk
X-Received: by 2002:a05:6000:603:b0:446:ef9a:8f41 with SMTP id
 ffacd0b85a97d-44bb6e8e014mr13915887f8f.40.1777885172458; Mon, 04 May 2026
 01:59:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430-si1133-checkup-v4-0-fb3e9dce41bf@gmail.com>
 <20260430-si1133-checkup-v4-7-fb3e9dce41bf@gmail.com> <afhedNn1hSAXyqK9@ashevche-desk.local>
In-Reply-To: <afhedNn1hSAXyqK9@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 4 May 2026 10:59:21 +0200
X-Gm-Features: AVHnY4JqZAwdQo-YPi_uHmrcPLfiskQ7bsjY1xK-ucPdoZSy6f9Pcd4Ys0FcnKU
Message-ID: <CALoEA-yhUAMg8d5hbYVQ1pAdY1TXL3Fwy_h8O8mbiBaAu_dKsA@mail.gmail.com>
Subject: Re: [PATCH v4 7/8] iio: light: si1133: add local variable for timeout
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 May 2026 at 10:53, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Thu, Apr 30, 2026 at 05:04:27PM +0200, Joshua Crofts via B4 Relay wrote:
>
> > Add local variable for timeout to improve readability.
> >
> > No functional change.
>
> Hmm... I am not sure about this as previously it was one jump and now two jumps
> over the code to get the actual value of the timeout. OTOH, I don't care much
> in this case.
>

This was actually a suggestion by Jonathan, as the original indentation
of the function parameters was horrible, so it was better to just add it as
a variable to improve readability. Perhaps I should've added a suggested-by tag.

-- 
Kind regards

CJD
