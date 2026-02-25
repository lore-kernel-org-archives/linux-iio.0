Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124DE3EF0B7
	for <linux-iio@vger.kernel.org>; Wed, 25 Feb 2026 19:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772048675; cv=pass; b=bgjuRhszyXIOWXt5ebkhlsXMfYdU+YAmuJiONUmoNHd0aJoq8P4rG5lz+ve7do6wLv11HsOa0bgxgIZbf/wmo4WOhZOdGemdAmyT7AcyOcSnZv7yMngh+eeMD0A3BHMM9qUnt8uJCEnPq95svbpl9GQMs6Ks3J5m007d95N4zWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772048675; c=relaxed/simple;
	bh=4xT+KjYnZ25wUvIDEWREa5jS5ix4fVdm128/G5DZxkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bhrTbaeAN8XUJIAmtbdZ+9ZlAlJaum5dM9QpcDoPpqHneDvxL0gLr8H4IDQGrruOd5oCS12v0xe9kpF5q0uNE4Rb64BfVaMl9WCy0/Vgy1a3X8QLyKCPN7C9YcqjlxqaOqRtm3vq7Kc4OacgBaiQtPKxkJrILj4iX1XsiDht098=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFUGj+1A; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFUGj+1A"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b8f97c626aaso12805966b.2
        for <linux-iio@vger.kernel.org>; Wed, 25 Feb 2026 11:44:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772048672; cv=none;
        d=google.com; s=arc-20240605;
        b=VFfkz1vJ0+JrJVuWm3IDyZrLKgrT6+VDZ98CDQDUTYJ35PxoxGkkyUiKpxKJHtaE92
         xrkOYEsULk6CdAIehu/mn7eVuRSyPwLjKwFdH9GBibEDpo9LfhnQWeaP3LFeqNzR6TVF
         +/WfJUnY0MC8V7eEy/kj3V1Hr6mykLw9D2En7bEpAVnk6y0ObIlhgf/rlSlmT22f2qPT
         M+FbyR1BrMj8mgYI9K1gpQJrHwNoVaYzXUPDhjzNxtwkZzTfcTTRG4ZrGNFJ4jZjFrgf
         ACJqh2cXEoeNA8QyjmqT6EdyM8QxgXnNDtlFNCdwOiO7zbvx80fssJCI9cE4nxxn/5BJ
         v9HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4xT+KjYnZ25wUvIDEWREa5jS5ix4fVdm128/G5DZxkg=;
        fh=kyTobP51Qu9H6rB5DIt1xCq68LBY8L3muphMRKCn/M4=;
        b=AonUoeCReQhXh2nocA47wQSH0qVwvEvuh022EuLBjTZLT7xk0JwRkaibIoGUa7ybXu
         pH2o5RoufAh8fXwH5/Se/XBIjUKfw6r8V1Gwhd2NJrX9mrXJy+q8yS3rXqMqmwtw/3Zp
         lVEuyrcEdeGmHgwRElsVFGZvFg5+2fcthCGYa9j++7cXfqhLZeeFC/+iJ7Kna9+dOEmw
         fc4Y4R0E5Fmq3jpoRQCW2jAR5aok8n9uiQoHH2PMuBg92z8bfrIOiZk1MOx7Ts1gCG6v
         rWmJbh4LXMCZwJBQ8XeUMQrfIswbG1kN63ryR1s+UHkPS4kGr4a16jpn45Ua1CgwE5+z
         fSFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772048672; x=1772653472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xT+KjYnZ25wUvIDEWREa5jS5ix4fVdm128/G5DZxkg=;
        b=cFUGj+1A+YqpWa9km+Gw1fjJ6qsD53bdaX9wkhpy8/D7faLGwtLNTe6td1OymWWkC0
         NNNlJw4q5B+7seVPnZOJX1taASwsZ95Lru5vORpZ1h58snW+heOd2X5BfHbZjyy2/Kve
         AOhkVS6RBmRzBqUrQjdLXHO2wreTMUvCIH2I6II7tj9LpS7I9rKzV2f7x3heBxmleEdv
         ctwfml8uqocfIhg+pKOELtBH75INitJUzAxH79c+UD3unnxc+s18toKj1I1OwNIAoTf9
         lkfdrwxu+XH7F30Lr2vS5qKcLiL/xIzBvLk//HU+E8YbE7KnoMeK9y2HbB62L6P2cmOb
         RD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772048672; x=1772653472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4xT+KjYnZ25wUvIDEWREa5jS5ix4fVdm128/G5DZxkg=;
        b=Py2JojyNXTZplXZqJ32wfllO76FsTSNjF6mN2qY6KImCRdcgqnyNVPYHbgGSpQJVID
         H2eoYH5194qjIKVjiVBJvuC92Nvmn+hkoY6npNhC12AjP1K6QeSLS+K/3/yRyq0csKTw
         rtVx/90KEWHeKz7sKYJdkDFNFDxey5F0JuUkjIxdrXOilh60svqEaLn3kZ4O6R0H+jg0
         lXiztDC8x3AnZBSi9NciiPAj8AXLViI2Vr9Eb9zaGmA1fIw4+kt2n6uvMklM1KRnm2Hk
         hKxK7lMlbW7jscFgnqTvLU6typ/7uTCE3xshRv5SlTQ3jFQ+KjG9+9awNmjJ6lX+cU8p
         ZDvg==
X-Forwarded-Encrypted: i=1; AJvYcCVCLhrx9D91dThsocxrpWSGxpEAh8sxRTbOowSDE/Hx3JmQZymSKNDoN/tqn+z5tXY6wmpjVNGh7Uw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6OSNbvt5rK/VsuWCbP62zp2ZZIyw0UOW6OVY5Jo7nZO3nwMNU
	nzJcAyir2WFczfea6ynHv5W9PTyc8RsddxqRDAfS/5VbCHbBGqgHKeBx3Dwa271dt8+jX217OqH
	SWkjZpJ+WiS2uR5GaYFoytMd7j2NDDec=
X-Gm-Gg: ATEYQzw0Evq5yinnXyLVA/pu6nhT6EDVzhFESj9Hvlnv607KHVsLQeqdjzeNXNWaKyj
	hETEJXFa/pj6yhPepZlNdK1dUZWEc9CTSzgeWpgmZvkQq905piCPETXNNxCHRyZxr+ZdZnQfQtD
	cAx6UC+Br69CyHAWLHhF9uK2PkTVRQK1bICyjBDa4DjTZGTvJxGNsIZC1MV1jnMLogEw1HuflMl
	wmbch+YKMP7+NbbT/27w6SDHBmm9wHzLMddXsVl8678dl27IM/5IR0TgjSMb4dkUR4dKLkmU87b
	Apap8/UB8VMfvNMtZTkkToawB4eo0YMB4IvcWSsi6giKctBk4jDa3CM+nHpqzBRk48xPybL5H6/
	DYm866u0=
X-Received: by 2002:a17:906:eec7:b0:b87:115c:4a2b with SMTP id
 a640c23a62f3a-b9081a4c646mr1167585866b.25.1772048672182; Wed, 25 Feb 2026
 11:44:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225194051.8614-1-rougueprince47@gmail.com> <20260225194051.8614-4-rougueprince47@gmail.com>
In-Reply-To: <20260225194051.8614-4-rougueprince47@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 25 Feb 2026 21:43:55 +0200
X-Gm-Features: AaiRm51B2rGu8AhnR3tMJxcqxsjvqGhuyqrNjZpQ7RwBdzMOlm0jbY1toG2aWks
Message-ID: <CAHp75VcMGD_4s=Que=J=eW3vCefFiM73yNhyfV36HvQUCOuZHA@mail.gmail.com>
Subject: Re:
To: Bhargav Joshi <rougueprince47@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 9:42=E2=80=AFPM Bhargav Joshi <rougueprince47@gmail=
.com> wrote:
>
> Subject: [PATCH v5 3/3] iio: frequency: ad9523: fix checkpatch warnings
> for symbolic permissions

Something went wrong...

--=20
With Best Regards,
Andy Shevchenko
