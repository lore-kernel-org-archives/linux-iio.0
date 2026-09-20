Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD1213D886
	for <linux-iio@vger.kernel.org>; Sun, 20 Sep 2026 04:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789877585; cv=pass; b=ICnus6uV0d+4WAbLhbjGFdLyh+WLbZ/m9YSg73V/KVMS7KQ3ojVzJV/g3vpiJUWsRe1Kfh+odzotk+UnODAoPnYBgEu5ViIyeMbrbvta6Kc8W0MZ8r5iF163ZDNcqrnTdmDoZDpoQOouPF2r+fqLNgVbwHl7aqNcBR4Pw1QtYDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789877585; c=relaxed/simple;
	bh=YnbfoGjlPz/vXewRAon37V0GQH2iNlW079+n72DtnPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+yUxESoiPTikxMGvukdQg31/5WR58iPyGbAj1wW7Ywf8jEq/+9+9ZTten/ttEo7+O4AWLx8JzzwCVZBB6pMqnaoeSdy9hohviVcYEkEaCCoNMw9ijzTViwOsLrLY63VjLV/0OsEvnKRT3EzH4ZOnHHkUPyPuhSDAv6jv15ippw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYtZjSgO; arc=pass smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYtZjSgO"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccd4f99cso2146541a91.0
        for <linux-iio@vger.kernel.org>; Sat, 19 Sep 2026 21:13:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789877583; cv=none;
        d=google.com; s=arc-20260327;
        b=borg01Z1YU4ogcFkoU5PB7BzH03D0U+KBV9u1iLGVX6sExyIiiYQdNPHXMMu+qb1lN
         oHskB41ofZsVRZ2gmi6b6cHu6ZYRLmuJnEfe2+2hNxgtM6/5d398teaRWM2iylHpILUG
         ezy5X/VJTw8ig50P8623VuN2ggR4DdIx0sJqnISypXEV7ZEXIO79l1tr0E6CBNi4pyVg
         tBT+h74OX5kKtD+QonD2+lj8LEDSvCylrLt0+ru6pcJ6km11v3PHjmmgFV+fExEXjIqj
         u+SPzHPRyXKD/13KGot0bODwlMjMCKHLjTPoRogDddDxddHBJvMYAP2oCX3BjBSCiaPE
         uSCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lMBYWtgVXyvrDIrr8C1PhgNJhaQAaWgNpoxuhRqTf4E=;
        fh=SS/yhfOMBubnvlk9ISa/nQP49IC4RfojwqubkQZRFIY=;
        b=TAjwnQTFIaY3kLYSsqDm/zJ3u9P8NuBXIgEwz3+1IThwZQghbMli9C2LUs7+Lowz/I
         YTDjzLSWZ/AxFIh86Gz5+ZrbfBMQwkaUMVbB9YUYsGxusJhVMFMLT1+sogYTG+mbZU6Y
         jKNQuDz80I+Xqhmi1H7YYbRaEfcgWkq2HeS/hELgadyI28jBcNYbJyG0td3RcS3G1i2w
         JTsTFCDU768oGAqd0aSzOpY8Gknn/E0wWLMcMFGRX54tJXwleS0QNclrkP7H/hVwdADR
         RtJtd+IzWpvPBJJeJcC/p2s9KPYoe3Mcflg6oYAOmERgyiMVJftBkiNZ94tV9c+JnNpI
         YQtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789877583; x=1790482383; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lMBYWtgVXyvrDIrr8C1PhgNJhaQAaWgNpoxuhRqTf4E=;
        b=UYtZjSgOb7tWjVBeUmKh94Ecz4mxJxMYlkMSojAc0SbuMaD9X/JbFHzze50OUNnDnT
         VsP536xgyq9Y179EtZVUsXc6oFXJNYzmn9unqKsal/81JM1xltkCMkwW+PvWF5HmA/UF
         fU3armDbeUKc6IKSxfH03JdciBAbVgY+J94E5Wx2fEhyn4E6LMlDigmnVVCuu4bvnHzl
         BeQBWdKIsPksQVKFByO8Q9uFyFTM8KfgQSmugBVJPsMyanfLCqeeCXqMHz2+pDAt83ar
         mDkn896cOq6ZbgShX2QkxH3q2Cr0bJiL08o7edTopFyXzEIc/5vOn9BKslRUm2YtaKnD
         m+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789877583; x=1790482383;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lMBYWtgVXyvrDIrr8C1PhgNJhaQAaWgNpoxuhRqTf4E=;
        b=M4ZG5Gnmx9QmWs6bTGSvMKsvK1834V7w+y2/nonG89txFtp86pMAfX+hYgPDiJ3+r+
         2cMGKpNwZWGY9JmNds3cnq1C2/vRMJ+9a1rDbljoJa3fYhDYsD6MWHkRZQbjIhDGYSpo
         8W6zvnvUOj+30zV+0/qpNHdPmOvhtciCYvr21BwJG19yH/+C8SWcEIgUycdXMr/U20wt
         1m9376CU+9VmXMka21ZKLaCXP4SF1BBxNpYVC+dfUbJ8Ko8z4ByJGSsd4i0uNxclBTjf
         hRmea88xrTJi4BMS4JA1PUOJcc0Sorwzpl+zKQlbl7yaBQ1L5n4WzqjVIrKmj+ihE/kX
         kNHA==
X-Gm-Message-State: AFuF++nnGrnRRQKipT8oK0AVQSyEb7j6VBXdOs5nEMEcDQWfPPFGp5jy
	lgfNFzpc9e6JbWg5PD0k4zcqTIEzTs22UUbk8xsEQw4BUfYo8i4n9kwJyMQW3cx2A8YW/W7O7sV
	bem2ai+Tgw7TkZ2YTo9Z/poUm/UmykY8=
X-Gm-Gg: AYBFou3gh8ibNQeIJvhNBHcJgRSwfggovHlEe8P3J2P2lb8qc7ZCpSZ0gZy4rDfXag2
	zV9WIZAJTEiM7H+CID5HAr2N1tn0YzFBkBdlcAyF+popSYh4JaI1EbTRoHFDpEhKtY/XtPYOU73
	LbmCKmPZ1D3ix1zUDKVe3G8Y/4QJFcJ4S9EE+LV4skHkA2WTPuizafDfTGgm21xtHX7xJ/yA8gv
	G0rF5bh1ljQtvE/Om1Exy8YKv7D1uWdka9p+zjy9U7neeCO4yWp/pH2UvQY9TnCLD7zCWULxZp2
	AWNOFxWaHxnyRSj7RNSn25FY6lv2WtOueAs+8Y4PXLRlFBsmGuOtePIImcFMMEvBjyLOSNfAQ1E
	aLrMOYF2UuplgEezNk+X7zSu3+AFyNL+E6+Z4OeLm
X-Received: by 2002:a17:90b:53c4:b0:39e:d2a:e2dc with SMTP id
 98e67ed59e1d1-39e54d1ea4dmr12330513a91.12.1789877583183; Sat, 19 Sep 2026
 21:13:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789753020.git.kimjinseob88@gmail.com> <e9d1f8f8d69b76797d617965f263df97b2b586e0.1789753020.git.kimjinseob88@gmail.com>
 <20260920023057.71ef0eb5@jic23-hlaptop>
In-Reply-To: <20260920023057.71ef0eb5@jic23-hlaptop>
From: Kim Jinseob <kimjinseob88@gmail.com>
Date: Sun, 20 Sep 2026 13:12:54 +0900
X-Gm-Features: AcwNN1XJYd9uoJcaQ1q60GQ-gnIw90dguuHYkkkGbV7JngEnuOZEzR8A-Daiweo
Message-ID: <CALMSew+LJjky+3uSSL3kByzpT-tkNmJTDurykNmH-nj9+zxCJw@mail.gmail.com>
Subject: Re: [PATCH v10 4/8] iio: osf: add validated stream parser
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andriy.shevchenko@intel.com, linux-kernel@vger.kernel.org, 
	rdunlap@infradead.org, joshua.crofts1@gmail.com, u.kleine-koenig@baylibre.com, 
	julianbraha@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, devicetree@vger.kernel.org, corbet@lwn.net, 
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> You could reorder these two functions and call stream_reset from
> stream_init. Would make it clear what getting to a 'clean' state
> means.

Agreed. I'll move osf_stream_reset() before osf_stream_init() and use
it from the init path in the next revision.

Thanks,

Jinseob

2026=EB=85=84 9=EC=9B=94 20=EC=9D=BC (=EC=9D=BC) =EC=98=A4=EC=A0=84 10:31, =
Jonathan Cameron <jic23@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Sat, 19 Sep 2026 03:24:42 +0900
> Jinseob Kim <kimjinseob88@gmail.com> wrote:
>
> > Add a UART byte-stream parser for Open Sensor Fusion frames.
> >
> > The parser searches for the OSF0 wire magic, keeps partial frames
> > buffered, checks header length and payload bounds, and passes complete
> > candidate frames to a registered frame callback.
> >
> > Candidates rejected before validation drop only the current head
> > byte before resynchronizing, so a corrupted unvalidated payload length
> > cannot make the parser skip later valid frames. CRC-valid validated
> > frames are consumed in full and classified as handled, ignored, or
> > rejected.
> >
> > Use a direct callback member with an opaque context and keep explicit
> > statistics for validated outcomes and framing failures.
> >
> > Assisted-by: LLM
> > Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
> Just one trivial thing.
>
> Thanks,
>
> Jonathan
>
>
> > diff --git a/drivers/iio/opensensorfusion/osf_stream.c b/drivers/iio/op=
ensensorfusion/osf_stream.c
> > new file mode 100644
> > index 000000000000..e262415e69b7
> > --- /dev/null
> > +++ b/drivers/iio/opensensorfusion/osf_stream.c
>
>
> > +void osf_stream_init(struct osf_stream *stream,
> > +                  int (*receive_frame)(void *context, const u8 *buf,
> > +                                       size_t len),
> > +                  void *frame_context)
> > +{
> > +     if (!stream)
> > +             return;
> > +
> > +     stream->receive_frame =3D receive_frame;
> > +     stream->frame_context =3D frame_context;
> > +     stream->len =3D 0;
> > +     memset(&stream->stats, 0, sizeof(stream->stats));
> > +}
> > +
> > +void osf_stream_reset(struct osf_stream *stream)
> > +{
> > +     if (!stream)
> > +             return;
> > +
> > +     stream->len =3D 0;
> > +     memset(&stream->stats, 0, sizeof(stream->stats));
> > +}
>
> You could reorder these two functions and call stream_reset from
> stream_init.  Would make it clear what getting to a 'clean' state
> means.
>
>
>
