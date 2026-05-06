Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1B73E0C5E
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 09:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778059187; cv=pass; b=ohn+dL9ksGg0jWC+uOz6ZkmLey7PiHJa6/VQOKwHvGcOpxVFCODUYd1ovWpTXmhmlNj+dDMQBeLQUCZtmZJoR54HOHHG11/LEwMXHDR0q0kwHizFl5G8ZQJPQEhxFfKDSrGUw0SvbxJ6P6NHlPIYk4p2kNRaPgR6EtnbWmzSiOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778059187; c=relaxed/simple;
	bh=CA3ijrUcqS8OP4ga0Eju36nwL472CTYxPLJe0dZS5Ws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mX7iACZjwU5SNrYDRAIgNLCOPmAAd7PcsVgVPVP5ued46eT4CT3TJ9pkdHdscBzktOAqJoTd7sMotO0xZ/h42DKBCeN8EjbKqdiu8SUQ1sPAgi71Azyjzc4P9OaDs4LGmx+NGyjmR1PDRSP7DTLd4mFeACSe095UkFh3/te7UjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b76+yX2Z; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b76+yX2Z"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-44ce78ab5feso3187872f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2026 02:19:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778059185; cv=none;
        d=google.com; s=arc-20240605;
        b=b8KO8xn36dlWC4Rm3ayLjsmXdmMFAr4kCKJvjKdfD4MgfqHL8U5hGqZ2QWlmAsQcN9
         8w0e8/UVBeUHMBwiaYRfHaTuZrRpAl3IN90+/+mZnO1s+jyuFMmf99BzjSrah3dJw8m4
         AujDm6yEM6h9017AwFOLhj1e3ap8cfv099d0OGFsQe3FsEN4ZxkgrTa1JGEJY0Z9ocWS
         NORawwpQrJdffOAFHGsI0PpdA6KQe75qieura+4np5IXoQ3gYBg9IoCrOOjQiGjiWrVO
         qKhw4zGlxx3HBUkzlHRvIQQhjKQ+voH9mILPeYK3GTuc9vwb90+DUv1vWyQXArHyZWQS
         MTCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=X8lYpXwL0HjN7BJwf4DpHto27WbK+KQyRN8rykXAlqA=;
        fh=wEuObbaQkNtJvxsaVmRu9NFDYfMgsCkRo5W0mF61Y9U=;
        b=GAalZ7PB24qypd3Xtum05Yy0IGgi6QoPl9FQNSGcQH5v3ajj/8bNTErZ5p9VpAaMsi
         Frxd076unqhGuL+73j3IViWaCluvSuUaywz9eos88CT0hidlwcvITxCbKVB1kB5yUguI
         v+1Qnzqkkqhzm3bAic4XxCe+yk/WBg083IS0pdsZndz9j5CnAwgafhjlGhbDJR2tinBo
         5hG5JrCjDWIoOAssdkmbgHRmv+VF0r1ohSjoVi4ct7y4QX/Dc0BYzBxjDSLCASdiXa6d
         FwmBAcfdSeaaDuSJOxApKjRqS3zJz5l9iMe7DPWozXjdr0fWUzfy4eHXRwtzhcEeqGzM
         9n1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778059185; x=1778663985; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X8lYpXwL0HjN7BJwf4DpHto27WbK+KQyRN8rykXAlqA=;
        b=b76+yX2ZLJiNUZc4d3PYJdoRxVG8/N/yqJLqsrrA4dlNKR4icvuZNZXmSmMktVH/0Z
         i96doyE3rneZyEEH5DQGS7SHGU0APbxY2mXvhB0E1/7ebh0x3bu4emNwlg/X1U3WlPd+
         T45NaPXE7vFXlqdloTIK2XBEW6nTYA5COjFANJwQO9aoept8wkbakta63amIGRhZo2e7
         Bap30LR3lUJvSUzaoBFixS/1Z8um2/3b6Mg9b7lT0mUFpgktSP71fOp5CvEzCe7HVP7b
         DKVzvwsf6oY9ldlFgTwpYj2tuyxP46VKlfvXQS4HIhKsEnHvhHH7p3KW19+zObgPmCab
         lnpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778059185; x=1778663985;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8lYpXwL0HjN7BJwf4DpHto27WbK+KQyRN8rykXAlqA=;
        b=RzYNJ3hn7NFyEd3O1BopOIXgKTkDC8DWAvAusvUZ5l9aaaCOJ5/ddAz2KojppIXTuY
         ykiIfiWKD9rBewFDhl/I9P0FANjhwzKI5lPyof5g0/cKBM8RfF+sdDOHjP3xR+TmPXv8
         9sm1/A2Er7mvpEOrwHO+HX5I3JdZjkYCSS3O6nltrhx5qXM4gNxACE56VtgC2LtcTVzx
         q5JNR153m0i+ne5uIfvS3pMc9KLPrfYZKBdVuy6fjQ/oAYOtJSs2Gf9cncF4AdHVe2mF
         O4yXLex2Rv3w/2TcdqnBN4BjFMS3tr5jZ4QWteNSNtl75UwQcDPYARWP4t8acpP2QtWZ
         Euyw==
X-Forwarded-Encrypted: i=1; AFNElJ8ernAYp55td3yaEO3eW6ASyr+cBJLr17eSAplwQXelAbf7vyo/umDiG7HRmUFaarNQUYgmvZgEWDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNoMCf69WznfiPW4RN/kAWgcmf2cdvlc3C9buPwN92ikC1z/Cu
	pD4hl7r2OHKP5QeXUceCb0KdLTowrqH/7obDSuGEZiKWkvMtd1Z5X9VF9zUSa0HSzBeXbhOUEll
	QSzEU+45bflvlEir0WGBMz45JdtS2JSI=
X-Gm-Gg: AeBDieuNgrxglVzb/qju7xjsQOnedvd7HeuS/spxDxiOfsNrT1rYCC8wp4FZprwvKxB
	exjL1VRzpM8hLNiJ/7dzA0JFHbo3jLRUvf3IB3AC/6FD9swwQ3hMr0MRMwPmDOy+Vp2FjEe5Wmo
	CvtU59+5nyroNkhqYtxcFBvCtmI+FjLr2jRNFjBOLbo3+MWICHwdCgD7VIIlzB8L6O9mdEXEDPO
	5+AcoPX/8dnb5V1QOlqhZKMCkSXCLy5lpcXt7P5sA2fg1maWEk0hbsd4Bw7RtqTcM3yKWr/sSqJ
	JV7FMaihtjHD/oSb4a7ddhnOYSgIFtThxjhhCTzDe4ik1BCHjB1ZYzixZUheZIgipPZR+8g+HyX
	vJIg1BuKEQu3v08tzX3jyEjTMiKfOy/SkzvEuvgG4knaP3fLkSD40hbTLplcdm9DPGlZcj6sQ9T
	3BoaqEJtXIWEznaGd3Htt/G1CnRC4=
X-Received: by 2002:a05:6000:400d:b0:43d:69ff:6898 with SMTP id
 ffacd0b85a97d-4515b0571d2mr3594799f8f.9.1778059184703; Wed, 06 May 2026
 02:19:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505174640.3998281-1-sanjayembedded@gmail.com> <20260505174640.3998281-8-sanjayembedded@gmail.com>
In-Reply-To: <20260505174640.3998281-8-sanjayembedded@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 6 May 2026 11:19:33 +0200
X-Gm-Features: AVHnY4LNz7cxDjvPvQn77Wo6JL1lX9pwVB41t3LfNp4IODvxWjqZjCXkR2FjGlg
Message-ID: <CALoEA-y37XZMVSnzdUbmWKHOWxs5r=39DEVcs_G71vEQTZ=ntA@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] iio: accel: mma8452: use local struct device
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, sakari.ailus@linux.intel.com, 
	christoph.muellner@theobroma-systems.com, martink@posteo.de, 
	mfuzzey@parkeon.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 May 2026 at 19:50, Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:
> @@ -1552,7 +1552,7 @@ static int mma8452_probe(struct i2c_client *client)
>         struct iio_dev *indio_dev;
>         int ret;

As mentioned, you added the local struct device in patch 5, making
this really confusing (and potentially breaking if only a partial set
of the patches would be picked up). Please add it here.

-- 
Kind regards

CJD
