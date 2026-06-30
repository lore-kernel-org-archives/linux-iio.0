Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB0C3815D6
	for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 05:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782796041; cv=pass; b=tFlTzRaXPbMardtPhOuRzBcET3240Lq+jZuukMSyFkSoF71lRZPs7USGHQY5/dukuvZTd+x/3/HG6KUQ7BfTDdVT54BjcJafdX7S74gpoUW/N0eaXyj3iupHWSETFgdYFB7E0p06QA/bzRE7H4EXAC19F4OfxNyIaaRC6U/JcEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782796041; c=relaxed/simple;
	bh=mtH42a/X+js5IZI9/OA3ovmmkp3lft4aPB4QuYYjedo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VOy4cM8HmtKIHPjqneGaFCZ3atZAWRrVCFuYvZHONHY71e8usH3T6bexKjBzgoEtkd5PMh6sBA0yyasmwKQKEiQCJiEc5lLsK7tfJ3ACsm1Iv7YYdo1BrZtr9sUl9hgfLsJDP8gIdkGEyAz3iqp8mG3/dFvifwsNO6yE5x1SMW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ovt5t+4e; arc=pass smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ovt5t+4e"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-30c965eab27so8058675eec.0
        for <linux-iio@vger.kernel.org>; Mon, 29 Jun 2026 22:07:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782796039; cv=none;
        d=google.com; s=arc-20260327;
        b=HQXfW3bAX1kd+eHSP7ss8/+GoqJMz68dJAi70Lt8CBW0rXSBzewp3o8m3xDF5KiyJ0
         9/wyfxNby/zPMDGKRbfRZTSP6Eouv7ITik3N8W0Eyy+afTh0RFndIWNChkQBIAqKvMsO
         XZMqBftVWsmi3Xz1Wrxu85VMLloSr3Y6Rr5417+PYTgd7tw/wD+7b2BbtToW2r8dyPnH
         mON1PX/5X67iJyWOTyt2g8MXT++kiJKuV2kpfKBh86sZRkW6X63jVk00BRrbHQLFzKBe
         EnjidVyoNCw6pB01adW9FbXea8xcPbXtND8JBnkKa/0KD61F9WcFBvmq0EsOd44bNkDT
         xvgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1cbSqXIdUnH0DkqCBhZ+TmddU2vqyX501BViCmYjvhU=;
        fh=c64fyeAHj5QVVSCF7Hi6iHJfn6Ub1ZxLzs6yr4ruPXU=;
        b=fTmOJkeQ4sR1TQ/HzvSpjzNJBIFzI5+UgMNPyzQp4//h6/Sibz4jcjikc3cY5LqA1n
         J9PD2qifgiY/qTcU16835DaaeCPh1zMejpDAg/nbRMnRNme+hyBGMaobdpg797H7c2kq
         2sXxGLEmdvmKQtWrG9E5p3UX/PQac2H06y/Ei0W+viy1g7KRiqi4if1hI7CYxiZm52b7
         rlI3lw+jnbLJJ5OVV4omAWa0tJGz6s3U3fIuE1WuuWXY6p2XsZc9AKYhf1F3S+uUcBuu
         SRBNT19hYe0tbVgzCCLhMtNQ0GesyvbzfV8GxvLGw8NJH7MBRGbg0W4eiyzTZ0ccJuU5
         XDoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782796039; x=1783400839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cbSqXIdUnH0DkqCBhZ+TmddU2vqyX501BViCmYjvhU=;
        b=ovt5t+4eqjxBPjppMp3V6CEUbcyyBq4a+ynQ0KF6vVl2KMwZuyg9omoyWonhKINCw6
         7gPCa+SfoQQXRNFRJkTVhr/N1qCiaYUbdi7Nq6cinA+gHlGYx1wRmWJbxZ2R6wp352pw
         bFu7GJBvKC2uzz1PDxQxIf1peUtTsitQxAUXTO1geBXvrPBpcFHN5qvs9X0ZkBiHjIgq
         XZBATeQOQS0Ijq7+3zhcilo1jOo+NdgM1mwRAIe50x40T3Yl7e+o80c85UNeQXMHiUGQ
         7NteoeOhFL8t6QiHr917HEIl2N61oQQFEGJjpuOdP0M0HVCQUANgkuDtFVDrQRTtfQpO
         Hvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782796039; x=1783400839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1cbSqXIdUnH0DkqCBhZ+TmddU2vqyX501BViCmYjvhU=;
        b=VAyK/gPbGvzSerZIr/FcLlXC+DtjNyFo4JaJ+5b2nDADPMvMkmWz6B39YnTlDM7LJr
         WeaOJvDObJ9KGH/lJ/1Vjll4tl06xx3ffznnDzh5cIC2s7w89rsSsagt9DIrkY+Iotrh
         4B4WVbfhm8bHMf4P1dMkMQOL2TFwlgj9D3kk6OVV+p9mYcXYIDVtxzTf1ufG6MXy9N7J
         dskasA5rjjdCtbFL6+zoUDaOzfX/xR2vE+vw7ZdjkGOcGpJuqlOZbj5PfATrd4jfq3fu
         IylOeEFOS7hYzhKgUVgMWksWkixYk7udnmhEB7UjZqHOqvAg0rretcmhiPztZBEVokyA
         tpxQ==
X-Forwarded-Encrypted: i=1; AHgh+RrutlI3ZOzjQzId2msh/mNXYNeV/FdvlvtxFbhYwvHQh3Hhg0r4cfp+6YHs+qI1ScNlciijNbV/Fu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFtcL6/BUGr6brUYFp38buGokeK2+BElF2ylLEa6tH63Q2SJ30
	xXG2ztYV6vLTdvp1EY4wsN9t8kg8i5BKhCpA0jP5LixmYwCAIrEvvFx1U8NFPHR6hFUITmADbaq
	bZGKVQAmfrGRzbGnPDddMBA8SOMwqick=
X-Gm-Gg: AfdE7clgcGUizZfmnCesaTB85eKe4F5MAji+6lQVmfDvsWnuWTRjuxfwYhYSYuu1+su
	b2jDM0XBbOT3qldHK1V5ZG/K3GeAT5joBHiuv54kpmx8PfQyhsBuWGmLxp44YuWqEOcfWv7MQml
	u+gCPJu8//hel+VBbWrOwbiQQSJBQWPBNzZQxG6iIlyv4qPtiBtftzioRdBTHuGBGRt4Cf02PKK
	5j0NB/bJ34nq2P9+mmm0Ailsgq6HwEF/8Us0hUD5ILV3NmkLg/iqXculSvwJAcfxqHuORI+KDuo
	rvEQ4YzB+2KBsu9wY6+5xIWGafNLXJMtd4umCVSiYxgLfs7cP8KrGifgpThI
X-Received: by 2002:a05:7300:2141:b0:30c:a9a:ee57 with SMTP id
 5a478bee46e88-30ee12264e2mr1421177eec.15.1782796039144; Mon, 29 Jun 2026
 22:07:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260628191337.937-1-kimjinseob88@gmail.com> <20260628191337.937-4-kimjinseob88@gmail.com>
 <akJ7p17eay2mnW-Y@ashevche-desk.local>
In-Reply-To: <akJ7p17eay2mnW-Y@ashevche-desk.local>
From: Kim Jinseob <kimjinseob88@gmail.com>
Date: Tue, 30 Jun 2026 14:07:08 +0900
X-Gm-Features: AVVi8CcLREPZ2ksRRyaf_EJwto5nPuGQcQ5h_W2vUGw6KZbJZiiW6ND1dGc6Y1U
Message-ID: <CALMSew+yg0K=sKDxDRNzdLoWHBLxVOce8_2Reatro1wQMw4d+g@mail.gmail.com>
Subject: Re: [PATCH RFC v6 3/5] iio: osf: add protocol decoding
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I will fix these in the next revision.

- adjust the OSF_FRAME_MAGIC comment as suggested;
- remove or rewrite the overflow checks that are effectively dead for the
  current u16 counts;
- build with W=3D1 using both GCC and clang before posting.

I will also include these items in the review tracking before posting anoth=
er
revision.

Thanks,
Jinseob

2026=EB=85=84 6=EC=9B=94 29=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 11:05, =
Andy Shevchenko <andriy.shevchenko@intel.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=
=EC=84=B1:
>
> On Mon, Jun 29, 2026 at 04:13:35AM +0900, Jinseob Kim wrote:
> > Add helpers for decoding Open Sensor Fusion frame headers and supported
> > message payloads.
> >
> > The decoder validates the OSF0 wire magic, protocol major version,
> > header length, payload bounds, reserved fields and CRC before exposing
> > decoded frame contents to the rest of the driver.
> >
> > Use explicit little-endian wire storage sizes and designated
> > initializers for decoded output structures.
>
> ...
>
> > +#include <linux/bits.h>
> > +#include <linux/crc32.h>
> > +#include <linux/errno.h>
> > +#include <linux/limits.h>
> > +#include <linux/types.h>
> > +#include <linux/unaligned.h>
>
> ...
>
> > +#define OSF_FRAME_MAGIC              0x3046534f /* "OSF0" little-endia=
n */
>
> #define OSF_FRAME_MAGIC         0x3046534f /* "OSF0", little-endian */
>
> (mind a comma).
>
> ...
>
> > +int osf_protocol_decode_sensor_sample(const struct osf_frame *frame,
> > +                                   struct osf_sensor_sample *sample)
> > +{
> > +     u16 channel_count;
> > +     u16 sample_format;
> > +     u16 sensor_type;
> > +     size_t expected_len;
> > +     const u8 *payload;
> > +
> > +     if (!frame || !sample || !frame->payload)
> > +             return -EINVAL;
> > +
> > +     if (frame->message_type !=3D OSF_MSG_SENSOR_SAMPLE)
> > +             return -EPROTO;
> > +
> > +     if (frame->payload_len < OSF_SENSOR_SAMPLE_BASE_LEN)
> > +             return -EMSGSIZE;
> > +
> > +     payload =3D frame->payload;
> > +     sensor_type =3D get_unaligned_le16(payload);
> > +     channel_count =3D get_unaligned_le16(payload + 4);
> > +     sample_format =3D get_unaligned_le16(payload + 6);
> > +
> > +     if (!osf_sensor_type_valid(sensor_type))
> > +             return -EPROTO;
> > +
> > +     if (!channel_count)
> > +             return -EPROTO;
> > +
> > +     if (sample_format !=3D OSF_SAMPLE_FORMAT_S32)
> > +             return -EPROTO;
> > +
> > +     if (get_unaligned_le32(payload + 12))
> > +             return -EPROTO;
>
> > +     if (channel_count > (SIZE_MAX - OSF_SENSOR_SAMPLE_BASE_LEN) /
> > +         sizeof(__le32))
> > +             return -EOVERFLOW;
>
> Dead code because it's always 'false'? Hasn't compiler given a warning?
> Always compile your code with `make W=3D1` using both compilers: clang an=
d GCC.
>
> > +     expected_len =3D OSF_SENSOR_SAMPLE_BASE_LEN + channel_count * siz=
eof(__le32);
> > +     if (frame->payload_len !=3D expected_len)
> > +             return -EMSGSIZE;
> > +
> > +     *sample =3D (struct osf_sensor_sample) {
> > +             .sensor_type =3D sensor_type,
> > +             .sensor_index =3D get_unaligned_le16(payload + 2),
> > +             .channel_count =3D channel_count,
> > +             .sample_format =3D sample_format,
> > +             .scale_nano =3D get_unaligned_le32(payload + 8),
> > +             .samples =3D payload + OSF_SENSOR_SAMPLE_BASE_LEN,
> > +     };
> > +
> > +     return 0;
> > +}
>
> ...
>
> > +     if (capability_count > (SIZE_MAX - OSF_CAP_REPORT_BASE_LEN) /
> > +         OSF_CAP_SENSOR_ENTRY_LEN)
> > +             return -EOVERFLOW;
>
> Ditto.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
