Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A96A3DA7EE
	for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2026 06:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787900007; cv=pass; b=UxmWMR+LOKgqtNW2v7KaBPs+WkXGyighqVDYJpCCoB9E58Et8+jo4WJiKG94Vrj/EfJ7SqyI0Q4WhZcgHUq1bVRjQ0CuxnuyxmrxilETi+8MWeg93VOY7+zsiUpiV1fZBiD61O1WKYTl6GTfnMt6ESXNvJHpK0I+ZsJBijhEaWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787900007; c=relaxed/simple;
	bh=VDp1Ho4MwZv4EbvgCMmKUxapUtWx6PKpAmWR7S3IHPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FesOiA7CKHh2qjN71MWkUEPaliZehpNKl4kOWZgsuQHpvjywgb54/hB6kPTsnKFoTAzaBQkYvNXkshQJvx2xi2M0U8ESW/HhcOJGax1wyhc1kqEUlUBKUntzHxjGV22mGOYNEh54uvtSP+PY6WcDzBQWMGX/iyLI+PdhugoW9VU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qfZBbiNs; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qfZBbiNs"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39c953950dfso6418841fa.1
        for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2026 23:53:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787900003; cv=none;
        d=google.com; s=arc-20260327;
        b=FYYlsgLjs2swjm+JXcj0j8sMmRUQGQMs5tDbDNaiR2qzHy1+nLjGh+4tt++304Fqel
         aOORyH9gE7K/5bfkMaPZiUWaLA5uk4yxwsA6+8qFY391qSsZXHZIp/OQt0yzkj6uP0pw
         r4iZEzPvBJ+esexg+HM7MqaJtMzN8aAftzdiRGdBRpPjjogiu+f4SaUpq3ToR0ryUEP9
         gXorXYnWPvJulvstIaW22Lx9mPnjNZgt01NZW8v5Ja/BpP0OO8W01zZfaq0TmPWAGS4S
         H1drkmE+YxpMZlSfp0SFihY7JlnidT0A+TS0kfQARzDADMoWnXLaBNvWi/J0gdmL3CtE
         eXrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8/mQdiOJey4oznV7AyJvIvyzEleWgdqTQVT4AekpJIE=;
        fh=N6B3aQ1WJLfDmwfUo6k+n7M9308WS06+ENYdEvwecy8=;
        b=PTztiRGoVaNGe9NyHA+ytBa+cgv/B3WE7wobeyiGlZO+dQ3L9YT8j+R12P9MLn8kKQ
         INK108aaQ+QMvVQqgRgifk34NymHDAVOPT/XHP5xgVGKVPDN+Vb/SFHifI0SfPiwZ0mH
         01ukySR5JfqfPGADsOW8QqRCFL56Wip+3fVl1kljIwa0bWy7CDK32T7hY+qwvJScrkVe
         wGE1Ijv+x4/Ge5rWh9sp9tnRqBpwtX7NcaIBCvsRQgNnDOmuctmKkk6zDnU1T/2GRPzv
         bhUOYjxe6vKfSiIvesoNSR1WI/qTqx2qhSD4iqXtlzWDTiRtm08aTPb4FTzA7TDdnSe5
         Tf+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787900003; x=1788504803; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8/mQdiOJey4oznV7AyJvIvyzEleWgdqTQVT4AekpJIE=;
        b=qfZBbiNsWdbGSjKFpkTy4AtEGvG5q21Ik7XP4RjKVgvCSg8VRTr2R0ncSTvR0Exw6E
         7EXKSQV7TH89d9rzHxQLqI2EMH5Y3d69mOUErV+/XFmTLe8Em6FwGGSIVfvEPRN6IFre
         7x0mfarLD/vuz+mkFbjJrSuuZp8Oszy/ek3sMVQJNRMgBFWNj3b/wQnM7k+N9GEvHRSu
         jQLgk567CzaP6HQGWeDZjW3wWJdlUnRJHLXoMya/RrVsr8z/nReyYLbPbB0ZWOn55FFP
         UKv2/bj+sfKGg0KuDhx/8wTReHLOxbYfi7ckchTR1MlelC4pmXApJba2OgvnMtWLhXG0
         C6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787900003; x=1788504803;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8/mQdiOJey4oznV7AyJvIvyzEleWgdqTQVT4AekpJIE=;
        b=ecGX1Ha+X6p71SIMcmNw66VUthjXIeetpa1ShkS7s9H1Gs+x2Eipu0ymID0338cF5T
         vKDWnU9rEU2PJNftYsSCpK5IKQxLSZta6h6ooGtNIVSDMqhR7FCEMbYyfUrEps1+avnn
         0QGsTS2qCMJxHaM71CnnxD2eyGSqPGzGWB/FNzTnrg2nFCHYlpU3+qNv9GRCnudfCbCw
         VlrXJw3JICCW+Ayu65HVqJNwkG20Vnc+Do88w89YyuYFuFHu4hwoqq5JW/NYLVlJPxb5
         7WZjSYRP44iC7ZwP9POd6qzxYrx/ij/A3VAi1z+gPCwKDRzPwoqUP8BIbUheil7qS7Ua
         LXiw==
X-Forwarded-Encrypted: i=1; AHgh+RpS18r2Db5dyILJMdfECak66AKLbamUTmmKCGlO1HeExBQvZcUKYxjJKT4x3uy0s1Rh1+2LAMzvJ5U=@vger.kernel.org
X-Gm-Message-State: AFuF++mCbmAMyO8PkXZl+PnLwPfj8LU+Dj1YKOeRWqVX3nmcPpib69jf
	BOQid3ZWnvHQHUgwFLtNh7Hxq1SuxiRQL3u2nqbHcMhJERdadeS47j4NrD0w6Oq3rjgNz164h6p
	1mTXN+O5bE6Z+7udAaxZBegfUI6KxIjNWwF7C
X-Gm-Gg: AR+sD12q40zEfEn0o7odmyXLFnnGFd69XtY5wYjhtmfCP4otn1sVa1RLVOw/Yh7wCE6
	r4sJiCc+pepE+UsPoNk5oG3YU1MUwtdqexG1sXLw5s+0GnhjcQ+5ZIoDTl+4QYh6YPyUQA4sPef
	GRbHGfTdW62wPsg7PTM0ctWRf26u3gk5CAJiQbI4SUlrbtCm5KMiIENt48J/kboGjeYe/L3rmGS
	kBK/GxHpO2bWDmnwTEt/m/V7Q88F9LABuV93S4wgVfpuzyech7/fwYxVhuKSrC5OkDpbn3CkQYK
	DfpCb0xUiR7zyv9dh1gKLQHiQXl/RZ7bqcBKo4IRVEh0mRE=
X-Received: by 2002:a05:651c:31c8:b0:3a1:9562:73b with SMTP id
 38308e7fff4ca-3a301b16d7amr7296801fa.11.1787900003015; Thu, 27 Aug 2026
 23:53:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822062725.60519-1-muchamadcoirulanwar@gmail.com>
 <20260822062725.60519-3-muchamadcoirulanwar@gmail.com> <20260824010726.2849f3d8@jic23-huawei>
In-Reply-To: <20260824010726.2849f3d8@jic23-huawei>
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Date: Fri, 28 Aug 2026 13:53:11 +0700
X-Gm-Features: AcwNN1WSQYP0-fvQo2t11ibIgmSEw8WyeXQCvmMnxHqFizPZCb4cCawVOvt7eDQ
Message-ID: <CAO26r3RLnX4HXrKDF6akmG722Q2CvDU-uJ40Yfuu_wwJdGgA9g@mail.gmail.com>
Subject: Re: [RFC PATCH v5 2/3] rust: add minimal IIO subsystem abstractions
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-i2c@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	andi.shyti@kernel.org, wsa+renesas@sang-engineering.com, ojeda@kernel.org, 
	dakr@kernel.org, igor.korotin@linux.dev, branstj@gmail.com, 
	brucer42@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Mon, 24 Aug 2026 at 07:07, Jonathan Cameron <jic23@kernel.org> wrote:
> This looks fine to me subject to a few little things - see inline.
>
> However I didn't take the time to decode every line of rust today so ther=
e were bits
> I simply didn't understand yet.  So for this to be able to move forward I=
'm going
> to need reviews from rust experts!

Thanks for the review. I'll add an explicit review request to Danilo
and Igor in the v6 cover
letter.

Brandon Saint-John has been CC'd since v2 and reviewed the series at
v3. If he has time to look at it again, a Reviewed-by from him on the
Rust abstractions would be welcome.

>
> > diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> > index a56ba6309594..5dc917d92151 100644
> > --- a/rust/kernel/error.rs
> > +++ b/rust/kernel/error.rs
> > @@ -86,6 +86,7 @@ macro_rules! declare_err {
> >      declare_err!(EIOCBQUEUED, "iocb queued, will get completion event.=
");
> >      declare_err!(ERECALLCONFLICT, "Conflict with recalled state.");
> >      declare_err!(ENOGRACE, "NFS file lock reclaim refused.");
> > +    declare_err!(ENODATA, "No data available.");
>
> Do we have something says there must be a user in the same patch?
> A really generic thing like this in C would definitely be a patch on its
> own so that folk who care about maintaining a given file can easily see
> it without reviewing the rest of the series.
>
> So unless you can't do otherwise, break this out as a precursor patch.

I'll break it out as its own patch. The patch will note that the first
user is the AS5600 driver, which returns ENODATA when the magnet is
absent.


> >  }
> >
> >  /// Generic integer kernel error.
> > diff --git a/rust/kernel/iio.rs b/rust/kernel/iio.rs
> > new file mode 100644
> > index 000000000000..f1638160fed1
> > --- /dev/null
> > +++ b/rust/kernel/iio.rs
> ...
>
> > +
> > +build_iio_enum! {
> > +    /// Raw unprocessed value from the channel (`IIO_CHAN_INFO_RAW`).
> > +    ///
> > +    /// For sensors, this is typically the ADC reading or register val=
ue
> > +    /// before any scaling or offset correction.
> > +    Raw =3D iio_chan_info_enum_IIO_CHAN_INFO_RAW,
>
> I guess there may be a rust convention for this but from a human trying t=
o
> read the code point of view this need a blank line here and in similar pl=
aces
> where you have docs / thing documented repeated back to back.

Fair point. I'll add blank lines between the variant doc blocks and
audit the rest of iio.rs for the same pattern.


> > +    /// Scale factor to convert raw values to SI units (`IIO_CHAN_INFO=
_SCALE`).
> > +    ///
> > +    /// The processed value is `raw * scale`. The unit depends on the =
channel
> > +    /// type (e.g. V for voltage, m/s=C2=B2 for acceleration, rad for =
angle).
> > +    Scale =3D iio_chan_info_enum_IIO_CHAN_INFO_SCALE,
> > +}
>
>
> > +
> > +/// C-compatible trampoline for the `iio_info.read_raw` callback.
> > +///
> > +/// # Safety
> > +///
> > +/// This function is only called by the IIO core via the `read_raw` fu=
nction
> > +/// pointer in `iio_info`. The IIO core guarantees:
> > +/// - `indio_dev` is a valid `iio_dev` allocated by `iio_device_alloc`=
.
> > +/// - `chan` points to a valid channel spec from the device's channel =
array.
> > +/// - `val` is a valid non-null pointer to a writable `int`.
> > +/// - `val2` is a valid non-null pointer to a writable `int`. The IIO =
core
> > +///   always passes stack-allocated storage for both, regardless of wh=
ether
> > +///   the driver uses `val2` (e.g. `IIO_VAL_INT` only writes `val`; `v=
al2`
>
> That val2 is always a valid pointer smells a bit like the c interface lea=
king
> into the rust.  I'm not necessarily against that being a constraint we ta=
ke
> on but I'm not sure how we document that. Probably add something to the C=
 docs.
> Any C driver relying on this today is probably buggy for other reasons.

As you suggested, I'll add a note to the C-side iio_info.read_raw
documentation in include/linux/iio/iio.h. The IIO core always passes
stack-allocated storage for both val and val2 regardless of which
IIO_VAL_* type the driver returns, so the assumption holds, it just
isn't written down anywhere. I'll also note it in the SAFETY block of
read_raw_callback.


> > +        Ok(IioVal::Fractional(v, v2)) =3D> {
> > +            // SAFETY: both `val` and `val2` are valid per the Safety =
contract.
> > +            unsafe {
> > +                *val =3D v;
> > +                *val2 =3D v2.get();
>
> Why get in some places and not others?  May well be a gap in my really li=
mited
> rust knowledge.

This came up in v3 and I answered it then but forgot to add the comment
as I said I would. IioVal::Fractional holds a NonZeroI32 denominator to
prevent division-by-zero in iio_format_value(). NonZeroI32 is a newtype
wrapper over i32, so .get() is needed to extract the inner i32. The
other variants hold plain i32 and don't need it. I'll add an inline
comment in v6.
