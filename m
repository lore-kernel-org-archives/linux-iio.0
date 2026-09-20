Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8E313D886
	for <linux-iio@vger.kernel.org>; Sun, 20 Sep 2026 04:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789877533; cv=pass; b=Mbo+E4kv19Vvkg/Nbl8mCby4lOl+zI9+2eI93vbRVK8IuuO1nDWp/yV4s7ZObAoXD9sJkh/JF9pHozXA4I1x0+PfeW+BL3bTmiyX/ImwH4MxoIGw0QbpS7/9UKiHe1+agYdYN2me5Vh5SMxRJrg711f0SOOEF1b1uTS2+V8Kr8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789877533; c=relaxed/simple;
	bh=rwaqLd78gCCDxPhEWVmec1Qbp7cY3KIbWZB2b88z5ZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uYwc5G/x8mO47SwxgtbvCs9jo3i2wKV26O7f+TnLbtDJR2CGNBhV6r7XMgNDnTHVF+NDjptJ99U0dOTaq1v+/1ZpQt+i6umZJneb1wHIS+vMLWz7tuS2YmtAIpLMEs+RiCojJKH0evetVFhB6BXqS1UScprviEg+1jGopXtJuOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcbJ2Bmf; arc=pass smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcbJ2Bmf"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469a34907so2175007b3a.1
        for <linux-iio@vger.kernel.org>; Sat, 19 Sep 2026 21:12:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789877531; cv=none;
        d=google.com; s=arc-20260327;
        b=IVVCk0LgLX5hho0Maia4hIvXKW52ZbI80zb6O6booe8m7Shh+beoSbMgr8KokpXiVZ
         dKs1gS4a2aooHXLdup5s3Kcdp9unYfhJRcvgR4tq972jLSLw5MhNgUPR98kgr2vajhug
         a+dguupb4gcaQ6KKd29HPfIizeK5Vd6ra4xddMtPGyKFAIrYXGdpFnUIvegg4Qw5dDsg
         BC1JBe0tmoNRiMKsfVyYsdHtxtEgvjzHZk9UWRa9wfWus+kUcR4Vv5GWpv2ORxjgkhZX
         JiPLOR8o0XvAbl9zgx0sbuYsLOjofLAbxvz9BdJVY1Q27GJswT7js6qRIM/sTDLhvKmY
         sGtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QlZH2LSeOeUh7PHf/pc7GdeXM+jtt8B7hsy70gSGj5A=;
        fh=SS/yhfOMBubnvlk9ISa/nQP49IC4RfojwqubkQZRFIY=;
        b=cdNF0mHrtgAdEc0mnYYdQQVrlVbkXho5dXkjx4+9POLdBV2c1+GASyLrDe2WrmFq68
         0iGeIQxAeFtwaq294KivccBRO0ZOdM/ZuK5Ruy5pvAfD5empDDmhvIpVAMsoHfFUy6+3
         p1R44jPVPUEmrjyy7rpM7YQvsIYbppB7CCvxsSz293UOLTC+t4R0n6y1qRwCrZU6JS5M
         mu2d1yN8LdKu04/3gAg77+TNPUNvGAxyPBCAQFbJAIn152bXLSQFTQ/+Cj/MS5C1YEPR
         xL7VG4Hoj1GHfrgvg9dv6DlxWDJ/z8YVu2Y9327JAoJtXHvKH6B9rvIaw0Y9frImUDYI
         gxEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789877531; x=1790482331; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QlZH2LSeOeUh7PHf/pc7GdeXM+jtt8B7hsy70gSGj5A=;
        b=AcbJ2Bmf8Sz0U/Eo7z5xTOjBLxmx5X96wSNNRqzLiY0kia/Xqnx2wPPodwraHbMt8G
         bWGFsB5ghcEbtuBCZJUSM3m7lXxtbT3Ini/p2UNsAGhDIz6e3Y1gf1Ar4u3M3Gi7q9Id
         fzQ6KlELvgBaaZ8BcxZTIqdHdATvRotwAubeO28TeeORo7tIJYZqnB5Lx+9Fxgrtib5f
         btN4QYWgYPb5k1A5CwD1jIdLGaXGadNGiPT3/JyFoXbODSvCnDYBS7ZJ2ILopjSfkCUW
         YO7KI20PbuNUzFGCPKlyV831CFyramd8TsHuiMNXDbA10ggouU9AKNfIIeKHjar8wHg3
         mupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789877531; x=1790482331;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QlZH2LSeOeUh7PHf/pc7GdeXM+jtt8B7hsy70gSGj5A=;
        b=AITGVc8zi2vG3zBm6BrBAt+7rjVvJqVIkJBZL+TsoTCqlNHO1nPVuBf2rNqSRfkb8g
         L+oGGBFE+Wo95qdNDalX5WJkn4ATDRtyZVKlnoRCU1ZrF71gxPBSqUBGS+9RmtcI2qIp
         wXNSGRWocxLXgtUgqqAVhkA9qbNCK7eyRBtp2eN5/2HOmKOEX2K2x1rZTIBO46i9BnlA
         Zjb5wrZRrcYAZByZ1CNnPKRtN9TkcUiqFKmV6bDa1yZhw1G/E1IiC1wFdCqxJh0j2X43
         gcOUTBQi2GtU0fvdDKWgSRJGPlHwvyH64aM5Up22dxjYZ3MkayhfD3+WEDWtwYrcG0Hu
         ZgqA==
X-Gm-Message-State: AFuF++kTWLBCCfkjhNxIlrXwmaWYquLpjiq8WjltK7wXhNBL2YZl3N8W
	WKnS+A55UaZqFMtHoVa8kvZwGgcjTpo75tsbaHn2pdxAp8smW/TMU/Yh2vMOMPu1begNh+EzM6Z
	BDKuqIMc5c2Nw7iD70PH3N+h+LYrbve4=
X-Gm-Gg: AYBFou179TFDYl/xMWnlvh0sgUkz6fUbIUrjn696+M2hI77azxS7V7udrVTyD5mkPec
	TqBucTbRwbv7t3T4uzYnJodTJm5MWSSj9BOGYS2CpU2SM6aNrZaAy3LU3WMtD+/8+4bQC3XlYs8
	SbonOYxFle/kefBZqJvpaC9wmfWDeOEMUOGiWeFpHU3ugS8TJzsJcr+8poDiq+3B03faqOO9sqA
	I5mXMFB2zMbwY3DD26QobF3a+EYrzHPUreLWZ/IKy/nP4Sab5X7eLzjqqPPFCmzUGT8rYjKOLLP
	3ZvkcOzWO/bPdPPp5eRRmIUoVlu1ZRjJZn6yrlgD3a9412kRANc4vWafTSAcYSw4V3o8CZ2VBwL
	nOLX23jyveSRu+RbrO43f8BBfEOh8NrPPHFf13u3R
X-Received: by 2002:a05:6a20:6a20:b0:3d2:2afa:d7d with SMTP id
 adf61e73a8af0-3dd8c52d98emr12640970637.18.1789877530888; Sat, 19 Sep 2026
 21:12:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789753020.git.kimjinseob88@gmail.com> <a00b004a7ac283e1d6e307421292757004f09e62.1789753020.git.kimjinseob88@gmail.com>
 <20260920022737.4403fc6d@jic23-hlaptop>
In-Reply-To: <20260920022737.4403fc6d@jic23-hlaptop>
From: Kim Jinseob <kimjinseob88@gmail.com>
Date: Sun, 20 Sep 2026 13:12:01 +0900
X-Gm-Features: AcwNN1UU_ReN-pfK8MzdlfvZg5NTRSP-1VjnaEcQ45UD5XeGrgMYYEtFBppvb_8
Message-ID: <CALMSewJD=hGTuVLEQHTRtO3oPZD0jCNqsCtjBYv29OKdqwcU3A@mail.gmail.com>
Subject: Re: [PATCH v10 3/8] iio: osf: add protocol decoding
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andriy.shevchenko@intel.com, linux-kernel@vger.kernel.org, 
	rdunlap@infradead.org, joshua.crofts1@gmail.com, u.kleine-koenig@baylibre.com, 
	julianbraha@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, corbet@lwn.net, 
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> The above fully assigns frame so I'd do similar to you have elsewhere
> *frame =3D (struct osf_frame) {
> .protocol_major =3D ...
> ...
> };
> Both makes it more readable and makes it clear you aren't leaving
> any existing data in place.

Agreed. I'll change this to a designated initializer in the next revision.

> I don't hugely mind as it's your code + spec to maintain but generally
> for a spec with records like this I'd expect it to be possible to extend
> the structure without it being a breaking spec change. As such
> I'd kind of expect the check to be that the payload_len was at least
> as big as expected len. Larger would be fine but we'd ignore anything
> there.

I'd prefer to keep the exact-length check for the existing OSF0
message IDs. The fixed OSF0 specification deliberately keeps the
baseline message layouts exact, with optional extensions using newly
allocated message IDs rather than trailing data on an existing message
ID.

So I don't plan to change this to an at-least-length check in the next revi=
sion.

> Entirely correctly I think you don't do any checks or reads of reserved v=
alues.
> As such why copy them around? I'd just drop that field from your decoded
> structures. Not a huge saving but why carry irrelevant data around!

Agreed. I'll remove the reserved fields from the decoded structures.
The reserved bytes will still be covered by the CRC and tolerated on
receive, but they don't need to be propagated past the protocol
decoder.

Thanks,
Jinseob

2026=EB=85=84 9=EC=9B=94 20=EC=9D=BC (=EC=9D=BC) =EC=98=A4=EC=A0=84 10:27, =
Jonathan Cameron <jic23@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Sat, 19 Sep 2026 03:24:41 +0900
> Jinseob Kim <kimjinseob88@gmail.com> wrote:
>
> > Add helpers for decoding Open Sensor Fusion frame headers and supported
> > message payloads.
> >
> > Validate the fixed OSF0 envelope, payload bounds and CRC before exposin=
g
> > decoded frame contents. Require exact known payload lengths and decode
> > capability entries structurally so the core can apply support policy.
> > Tolerate reserved padding as required by the fixed protocol contract.
> >
> > Use explicit little-endian wire storage sizes and designated
> > initializers for decoded output structures.
> >
> > Assisted-by: LLM
> > Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
> Hi Jinseob
>
> A few things inline. Some are about what I'd kind of expect from
> how specs are often defined to leave a bit of flexibility and reduce
> the need to update drivers for new stuff being added.
>
> If you don't want to go that way I don't really mind.
>
> Otherwise main thing here is why carry reserved data to next layer
> given it is meant to be ignored. Drop it down here in the protocol decode=
.
>
> Thanks,
>
> Jonathan
>
> > diff --git a/drivers/iio/opensensorfusion/osf_protocol.c b/drivers/iio/=
opensensorfusion/osf_protocol.c
> > new file mode 100644
> > index 000000000000..e0d7c7a9ebd7
> > --- /dev/null
> > +++ b/drivers/iio/opensensorfusion/osf_protocol.c
>
> > +
> > +int osf_protocol_decode_frame(const u8 *buf, size_t len,
> > +                           struct osf_frame *frame, size_t *frame_len)
> > +{
> > +     u32 expected_crc;
> > +     u32 actual_crc;
> > +     u32 payload_len;
> > +     size_t total_len;
> > +
> > +     if (!buf || !frame || !frame_len)
> > +             return -EINVAL;
> > +
> > +     if (len < OSF_FRAME_MIN_LEN)
> > +             return -EMSGSIZE;
> > +
> > +     if (get_unaligned_le32(buf) !=3D OSF_FRAME_MAGIC)
> > +             return -EPROTO;
> > +
> > +     if (get_unaligned_le16(buf + 6) !=3D OSF_FRAME_HEADER_LEN)
> > +             return -EPROTO;
> > +
> > +     payload_len =3D get_unaligned_le32(buf + 10);
> > +     if (payload_len > len - OSF_FRAME_MIN_LEN)
> > +             return -EMSGSIZE;
> > +
> > +     total_len =3D OSF_FRAME_HEADER_LEN + payload_len + OSF_FRAME_CRC_=
LEN;
> > +     expected_crc =3D osf_crc32_ieee(buf, OSF_FRAME_HEADER_LEN + paylo=
ad_len);
> > +     actual_crc =3D get_unaligned_le32(buf + OSF_FRAME_HEADER_LEN + pa=
yload_len);
> > +
> > +     if (actual_crc !=3D expected_crc)
> > +             return -EBADMSG;
> > +
> > +     frame->protocol_major =3D buf[4];
> > +     frame->protocol_minor =3D buf[5];
> > +     frame->message_type =3D get_unaligned_le16(buf + 8);
> > +     frame->payload_len =3D payload_len;
> > +     frame->sequence =3D get_unaligned_le64(buf + 14);
> > +     frame->timestamp_us =3D get_unaligned_le64(buf + 22);
> > +     frame->flags =3D get_unaligned_le32(buf + 30);
> > +     frame->reserved =3D get_unaligned_le32(buf + 34);
>
> As below. I'm not sure what benefit of keeping reserved around is.
>
> > +     frame->payload =3D buf + OSF_FRAME_HEADER_LEN;
> > +     frame->crc =3D actual_crc;
>
> The above fully assigns frame so I'd do similar to you have elsewhere
>         *frame =3D (struct osf_frame) {
>                 .protocol_major =3D ...
> ...
>         };
> Both makes it more readable and makes it clear you aren't leaving
> any existing data in place.
>
>
> > +     *frame_len =3D total_len;
> > +
> > +     return 0;
> > +}
>
> > +
> > +int osf_protocol_decode_capability_report(const struct osf_frame *fram=
e,
> > +                                       struct osf_capability_report *r=
eport)
> > +{
> > +     u16 capability_count;
> > +     size_t expected_len;
> > +     const u8 *payload;
> > +
> > +     if (!frame || !report || !frame->payload)
> > +             return -EINVAL;
> > +
> > +     if (frame->message_type !=3D OSF_MSG_CAPABILITY_REPORT)
> > +             return -EPROTO;
> > +
> > +     if (frame->payload_len < OSF_CAP_REPORT_BASE_LEN)
> > +             return -EMSGSIZE;
> > +
> > +     payload =3D frame->payload;
> > +     capability_count =3D get_unaligned_le16(payload);
> > +
> > +     expected_len =3D OSF_CAP_REPORT_BASE_LEN +
> > +                    capability_count * OSF_CAP_SENSOR_ENTRY_LEN;
> > +     if (frame->payload_len !=3D expected_len)
>
> I don't hugely mind as it's your code + spec to maintain but generally
> for a spec with records like this I'd expect it to be possible to extend
> the structure without it being a breaking spec change.   As such
> I'd kind of expect the check to be that the payload_len was at least
> as big as expected len. Larger would be fine but we'd ignore anything
> there.
>
> > +             return -EMSGSIZE;
> > +
> > +     *report =3D (struct osf_capability_report) {
> > +             .capability_count =3D capability_count,
> > +             .entries =3D payload + OSF_CAP_REPORT_BASE_LEN,
> > +     };
> > +
> > +     return 0;
> > +}
> > +
> > +int osf_protocol_decode_capability_entry(const struct osf_capability_r=
eport
> > +                                      *report, u16 index,
> > +                                      struct osf_capability_entry *ent=
ry)
> > +{
> > +     const u8 *payload;
> > +
> > +     if (!report || !report->entries || !entry)
> > +             return -EINVAL;
> > +
> > +     if (index >=3D report->capability_count)
> > +             return -ERANGE;
> > +
> > +     payload =3D report->entries + index * OSF_CAP_SENSOR_ENTRY_LEN;
> > +     *entry =3D (struct osf_capability_entry) {
> > +             .sensor_type =3D get_unaligned_le16(payload),
> > +             .sensor_index =3D get_unaligned_le16(payload + 2),
> > +             .channel_count =3D get_unaligned_le16(payload + 4),
> > +             .sample_format =3D get_unaligned_le16(payload + 6),
> > +             .scale_nano =3D get_unaligned_le32(payload + 8),
> > +             .flags =3D get_unaligned_le32(payload + 12),
> > +             .reserved =3D get_unaligned_le32(payload + 16),
>
> Entirely correctly I think you don't do any checks or reads of reserved v=
alues.
> As such why copy them around?  I'd just drop that field from your decoded
> structures.  Not a huge saving but why carry irrelevant data around!
>
> Jonathan
>
> > +     };
> > +
> > +     return 0;
> > +}
