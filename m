Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D750364022
	for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 21:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773695569; cv=pass; b=fgfH3Sm6MFs2rjACF/dmX/1olNyvD7/o++4WZCQDV3m080FhIxi/favpJmx3Na/t5mqXX4OmMObEkn5Qn7v17/IUnfqwcjYnM2P7jUiFW7kq32x3zPLYxtIh6e1DLZwwLksNenoXDzrIgrg7tYmzG5zmpDrIesNcoBN2WcBEjMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773695569; c=relaxed/simple;
	bh=ZALAaySdVkGl93Xg1hi1CuHOmgw2MWfXrM8g4R27DSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jjrezaduMc0BTF1sKYXv0yrN0333262z+ZFc1YsTTfsrp+9Iuag+nBX7veruUNFLCBHtNiqdspCWNzcUJQyTGLz14nnD6ccELFKcyi4mrstQ+LWS1m6xkZnXfWj1+C63L3GUrOf8nIf+dAisfq5VK+e7P7XM3QGXprBXpG+XBd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nYtVk6Qy; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYtVk6Qy"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-66174cf4549so268150a12.0
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 14:12:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773695567; cv=none;
        d=google.com; s=arc-20240605;
        b=jx3Z7iCXHszbUeMYdsMZnT/9jFZ/fyIgvKhsgd8k8uSrMKPL8qaodO0eV8M7MmwqAf
         jgFgGvIvRbtAANeKobAcInK22v0zIDd3zY1hjpF0+uGF1QQMclGGpSpxwJzNUMSoc9Jf
         BCVujnc8oWIHph8bs1o/yDxnEaB4VQNErl2NjAxcDQaPmijboeuRbUtfDV8tUveMkgKp
         mLIz1VzQ1oYYYTOC6Zr+1zlJD9NC6nlWtwN3zUjiIgAAXsGSZ/26Krm1BiL78ZoyjogP
         GCP1O+7ns5HwxBSzY5P6c6ybT/2eOgX23aXOM5Imcrp0XOhq8LRqusXX6wG2RJVRwr8N
         WIBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vW5U13qJJCuHEPPTWHRyPBz0isrX//k/D71BiKJDO4c=;
        fh=hg04e15nWpNa7dUDmTSfwmb79SwSYY7c78kPX5wPHVk=;
        b=gg9Er4QoxJaMRbIttSebj+O/Yt9v+yRan2+cG1Bz1TECq+n1xO0Ywe9S9694ePCSFS
         32svtU49fX/uEHYBP2jd+KEYmADPjWoCllATqsUHg3fWS+RfXpmveUXjWLEHAEDbunJS
         XKyJ5Y2g8XM/kjX6fpblN8781gySNGBSoZdHnyfCI9Sv+s3HYBzeJrsEhNFBQzXNUCjc
         QBBladEFUW9qElIiRJ+eSFFQcD/fmqvg6ecFs9cgwtJM2wOgZPSvraxSgbKBGgw9Gg+J
         Vwv7APRce4zx64rrOmOPiOjuU0HsHMpn1nf2TSEAniGyh/uwuLTuDmbEkiE+rkrarA1i
         vOkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773695567; x=1774300367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vW5U13qJJCuHEPPTWHRyPBz0isrX//k/D71BiKJDO4c=;
        b=nYtVk6QyNOlTG5EtTkLGTRAHBUg5qMJSpOIoPgDKgo9YqoRcJ1ly51/aMELdAvPtkR
         sk2erH/Hq5vBhbWAGPK9uJzU3JGrzKZTVf/Zt6O2UTaI32O3gDhr71XhnKIAtQ148zwO
         xCglDr3D3+pNfRAY+0kJk+Y0kig16DsYijyHuVSzWquLHJzbGeIKiIU9Nb5S9AMLoAuJ
         5/+QjFc9/8pzuRjevqTEpGy7VXgN+j7ZGA7iYVD7RZHKKAgNHcimB8yKOoqXmHQLRhEl
         z2P1rYIVVL/tN+LqwE2QzCk3Br1HgO15LDgb8+Dlghp86nIfaBOUrI/DEAZwcGwxkVgU
         ZulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773695567; x=1774300367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vW5U13qJJCuHEPPTWHRyPBz0isrX//k/D71BiKJDO4c=;
        b=LL7txFY1jgzEOA3ByynzUc35tb1f171S225g9LJPRSXrN03LYqq/nQuMDFdYKKNxcP
         i7+46YPyK8QwhRx8SbflPv2XFAVM+RMlS92KSnRoD7/Cmj9WzTMej8SeTUQByAYVZhYg
         PLUgL5nW3TauugY7Qb4yfoqByF50CfCySWfNRSAG7cRbgy0cMgInim1YCmJ9G6emHrJA
         lX3WgajVR8C3NN0KzEKpSJl4zfFsQq7zTPJQBWSeQ2EmxsoJLtrKS4FO4sVplngRCAt7
         ui8+ifpMI+sqFKSqFPBCwUoDXcfgmI+CN0dC143UAd6yn6qDZ04YNsaRORweW/obCl+d
         lNdw==
X-Gm-Message-State: AOJu0YyfMjXtBmpKaKcXXvvcEKA1HONLvhMJDoYuf6+2cs0nud05BhHs
	cUjiCB9DX99on3rlDgQE0zPjGJEiunsosrdxIFEh0nXB/AAPpb1ysXhdg586upDtQCBYkmufLt4
	AhMFRryA5Xvd0eByjmUxejth7NAD/pAE=
X-Gm-Gg: ATEYQzzWcNin9ZXcj7o0e4SEUCPeUr5khnb6PXt1hLo+Jq6VwvX0m0eJ6SMUW9756kd
	/xCdJqDRfvDLem8dqlwtEHpGLT1+4NOHCPpI9G+YGgpMnlrJCEtglSqm6q6YszYXGXnuDzy5h3W
	4c6wGsxp+XDv299ow7wAGz7e0baVppyRXKbn24qUSWaMj3mdlcfGCdJW6m8sSvViRjuELh7xWUN
	FJinMzT88MkCyZTKaTgcoh61At1OAoPbsJEcCvAbiFUniaS3mezSq+O5gsb6zzJvkL7hyEtLBVG
	a5juXnyvSNpCjrO9hvA82yis/slWSBa4X0yTAQ2YvMGAaTnAbytKD9S68HigJ/Xnuiyuyz1zzgZ
	xVvQMdA==
X-Received: by 2002:a05:6402:1518:b0:666:f731:ea20 with SMTP id
 4fb4d7f45d1cf-66707bf6e85mr503622a12.1.1773695566693; Mon, 16 Mar 2026
 14:12:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260315224509.48111-1-rosenp@gmail.com> <abgQr6Ij_1Bpqb_R@ashevche-desk.local>
 <CAKxU2N-FopyQ51FVTWKzs7-u-MuEJVawxHX_t_iYBkpYMV4ezA@mail.gmail.com> <abhdcTpxDrXrTUqr@ashevche-desk.local>
In-Reply-To: <abhdcTpxDrXrTUqr@ashevche-desk.local>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 16 Mar 2026 14:12:35 -0700
X-Gm-Features: AaiRm51v0l7c9Wg-1Vwz2fvlVZZbaT_Ct_XVJvBfJ37WETZaSW8ZphV_7F_vJ1Y
Message-ID: <CAKxU2N8xj_SX7W0KncyeJ7NeL+kuyfkQ5zzrTj9Dipt8rTJMjA@mail.gmail.com>
Subject: Re: [PATCH] iio: iio-mux: use flexible array member
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-iio@vger.kernel.org, Peter Rosin <peda@axentia.se>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 12:43=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Mon, Mar 16, 2026 at 11:11:22AM -0700, Rosen Penev wrote:
> > On Mon, Mar 16, 2026 at 7:16=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > > On Sun, Mar 15, 2026 at 03:45:09PM -0700, Rosen Penev wrote:
>
> ...
>
> > > > -     sizeof_priv =3D sizeof(*mux);
> > > > -     sizeof_priv +=3D sizeof(*mux->child) * children;
> > > > +     sizeof_priv =3D struct_size(mux, child, children);
> > > >       sizeof_priv +=3D sizeof(*mux->chan) * children;
> > >
> > > There are two arrays that are allocated at the end of the same object=
.
> > > Why is mux better than the chan?
> > It's how it's already laid out. mux first and then the other data.
>
> It doesn't matter, right?
I can't really judge. This commit came from running

git grep \\\*\)\  | grep \ \+\ 1\)\;

which is the pre-C99 way of doing trailing allocations.

Shuffling this around would increase the patch size which I've been
advised against doing elsewhere.
>
> > > I rather would see two times array_size() than the above.
>
> > OK
>
> > > >       sizeof_priv +=3D sizeof_ext_info;
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
