Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1809038947A
	for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 09:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773914345; cv=pass; b=YG9Wdpw409jmiVjzKS3QZWyULKJmoDbRbuqTLooeamWqkqkvkV0Nqm/cQH29xJWMmv15BA+V6mrC52qH3WGi1o7KjTSYfQb8Ig2OTtkbk9wTxLQQtKXN0zs12boZgkEIB+jNevFihVe8MFfe5lzqdSkjqMWbUHAuGdoB8GpJ/2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773914345; c=relaxed/simple;
	bh=5GXFnzOvDLl40ngpoW92yBM/thWmZs6+gQm2yPj1pzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d1WVkIkQPt8XeYOksnImig+u2euQvSwNVMmyIbrMbEy+qQJXnAYAwUXIkq5e1d0z0SasROLejPRil8aRkVcPjxC/0YX7i/U6/5k3rXlmwyek3biXmUWpDaevBfT316E5zEejtflXIld/ByFOUlmaZH0K5c6Po5UsuOp8wXuazu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PV/hQHge; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PV/hQHge"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64ae58222aaso113424d50.1
        for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 02:58:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773914339; cv=none;
        d=google.com; s=arc-20240605;
        b=V3ro0FzjdPtYeZZy1dwRp5pyiBsKVLtHzbNisk1SIIFlu90wsepINu2ucqRiwb5ij6
         Ab7Z7dC2cjFnUF9SlY9wQf9nuiMJjph6pkVabujPz/HnqPEfOC7JxV85Z/daJ4yaa8ln
         tUSyrITiDOEyt4rY9jY245ZuEWh0FCpixnQCv6lVIQHEWxyTH0t+QX4KeZvkv7A3CUrO
         xo+lR/KE73Q4QEbrtpqhevuAaOUtY/69SibHY1rifgV8LxDxz4WhqXCT1F7ukZv1x2/j
         0A7XAmCS4oqa5xVTWVOl1aw9u9iq04W9DclIO9n9OQZbtd7cvBQ6zAmvQEBOhySRtXyE
         UU6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5GXFnzOvDLl40ngpoW92yBM/thWmZs6+gQm2yPj1pzI=;
        fh=rtpz5N9Gb/FuP9bgkntzIL7o8pOv7+d1YAouRCZHD9U=;
        b=ZniiIQtv60wwt4xX8mmGO5G4FJs66oKZ+CX2Ljf0VB1yhG1tlJ+oAJxvTbsc50B7qo
         wX8iMgSma7kBGYV3qgdGgMyapBkt1i5UCB1HfIquEyyn/lojdtcxqMyh3ndCZ5eZtZZY
         TS/jcmK3jwqZBGZwapfFeXZk5Pw8mEkUGE8tjhlGQlYdPD5Kci1u5IRFU7VRlcGUkIVX
         S5coF9Cfg5NqcP8MhW/fV1hjyJr42+kcdCxaro+g7bajIFfS+JVlMHPGhIImYD0iNj4x
         QpGIjXUkyYUOkrWWQRkvOprUqVhd3ejN8Gjoi7H2L7S65lwqjZwnVg4+/j8YwZGDl1D9
         ywhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773914339; x=1774519139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GXFnzOvDLl40ngpoW92yBM/thWmZs6+gQm2yPj1pzI=;
        b=PV/hQHgeJg4Bk+sa3AKqIV1iFCGFlm+BYRVFpNiDpxN3Dp0dfyExfCrk/w9szxeZSg
         M000UvGex4raWjgCHzZO9E4P9Iz5f3VyJdPzt7cdJyo/5f5Tcy8BP2/sPMD5YvxMfvvA
         m2NSgeQ4okuSNrNyTRqlZaIvjUwBHpF3J5pPjOjNlXrR6Llw+kELpx7q66zm4bz9TYj/
         4PbntYE+ys4f3RLiiUztIiJfno+PQO0AIZiTlIk/vZ1FQRQ1uYVzb+He/8XyHU+b3TQ3
         JjPoyfU9vhS2WJDokv48Dn3+1e+Tbc7U0H4znR/mIZq1fswmb4z74g+q0W0TbydXoRdg
         mwqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773914339; x=1774519139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5GXFnzOvDLl40ngpoW92yBM/thWmZs6+gQm2yPj1pzI=;
        b=K6Pk7i8iCpUsoxFkweQny0kQqezLhkTzYlzg+hoenKMO7Z1GV7QKwt4NZxYoraGqRl
         6cxBsAL7PyfyiBI+lLwdvjv66gu8brvKWzSZNNjASY53USzFDNpgXE86JyGU6VLHtUTl
         m6hEzEDUXeJF1diIuF4S48RfFjKpclE2O0hXwmaTzqLOxFAwJCuF0+laZzHV2AV3GyoS
         psX54qcQuGzla2EtOM4t8KPUEYmAlN4hlcHAfKD0TjkuXxsWn0AG6oeA562nYT2IVaVX
         PJsIf7x5j9WEZ4GPb0V5PW8EtjPbL8tyJcpjKNA9gldCXvEMFxluUkR1+krQ6hiHrl9z
         N/mA==
X-Forwarded-Encrypted: i=1; AJvYcCXebEpd0030wfvIFuWkQzlpi8fUu+rGVPCOm2IGqmy/sKehM9VASUaq1r29MEhd6BErUtWFVdHyLZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHAL7xuAVHnsX0HXeTUnc0LvZbtEi2XsMxIVvzb5ALZR/mSMu4
	p2ArZ8UUT468i+t0rbuCW3ZL65OB3vvngQ7eLuLpQ79khlT4IIwdc2vwSLB2AuWCBtAVggZumW4
	jhvYetFLTsYkkXoOGT21vPluge5EdTK0=
X-Gm-Gg: ATEYQzyaMZih3llJgBeIMGNqsyu4czPg2TxqZMiaPWdxpburik1MDICm0DmWlS9BGJb
	o+nN+oh/jolgodX+6iC0EPaMaVViZYcNiCy+X51nvf4Jx2c2qJnWWGyVREUZsyfou12CFAU0MCd
	1y9zARFiWl01ZTecj7kYD6yr46nNWJyhlwiv51m3fkx+auvAhJhnZInKMJQNyjWNTMRlJHb9hW8
	+b1THfs3KRodwVtqDXjdCLCso5qQYQc2M3+Mlpvi/E2Nmy/+0d+kgeQPPK/dTeU81a4QrtObkDS
	+mEo38s6cxxWVBdNxu0qJxeq7dxi5HM02rup/pMqHn01VKPaWtsR/7acEPRkCWSAxecmvXVX5FB
	r4pQRMZS9xVn+lHt9kqZtog==
X-Received: by 2002:a05:690e:4245:b0:64a:f23b:e2f5 with SMTP id
 956f58d0204a3-64e9147098dmr3804442d50.3.1773914338898; Thu, 19 Mar 2026
 02:58:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319085741.109359-2-giorgitchankvetadze1997@gmail.com>
 <abu-21Hi5eXkuGkQ@ashevche-desk.local> <abu_2Y6gjLU1aSHv@ashevche-desk.local>
In-Reply-To: <abu_2Y6gjLU1aSHv@ashevche-desk.local>
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Date: Thu, 19 Mar 2026 13:58:47 +0400
X-Gm-Features: AaiRm53FHo6leqWdkOyp1TxcJJfEEw4xcf9Vr1PIyFM2oSsl1zQ6swgB3UTl-jM
Message-ID: <CAE7dp2qDUExWnpLcUgksmxJ9bMVjvk2uTiYU=SkiZKC1ydjrqA@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: qcom-spmi-adc5-gen3: remove redundant OR with zero
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de, Michael.Hennerich@analog.com, 
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 1:20=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> Have you read the comment above?
> I believe this is done for clarity. No need to have this patch, but I won=
't
> object going it in, since the comment still stays. I leave it to Jonathan=
,
> but I'm not going to give any tag here.

Hey Andy. Yes, I did read and consider the comment. My intent was to
remove what is technically a no-op at the C level, but I agree that in
this context it also serves a purpose. I might have misprioritized the
situation or trusted Coccinelle a little too hard (Yes, I remember the
first thing with such tools - warnings are just recommendations :P ).

Thanks for the review !
