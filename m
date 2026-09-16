Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25F74968EB
	for <linux-iio@vger.kernel.org>; Wed, 16 Sep 2026 09:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789551912; cv=none; b=ZqxQqn9iXO+aV4FsPDPCUNe//EFE1W72/wCA7uVTY5K3De8SyHI9VVy8J8hzsl/gT95Ni75CFR+lvQzCkN1SHOc28ATMfycUt4LqyI8qZqMsmdNqIarBWCWhLfwCJJL8nlm/i/BX/iMj0qHmkTSDPyhz7voAgtIgIoxvTN20djc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789551912; c=relaxed/simple;
	bh=MR2n2E+Ve4xO4iUtdmDW34456DHtOWZBko8Pj6o1iIU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EInDx47Gngy+NwuHoPJoKLlNju18OjH3agWL+J24qPZ+W4f86II680+b76JfpwzmzOXzamj8Re4K0y/YbKu4iYp2a5AnsoqX8pRYN3ls4omaddaknIKAo1M0vMetIpbLx04WgwzsStrAQzSQxfLDxdLNRkbh8qg0xD6GNnsIcIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZLSb1k0; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZLSb1k0"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912d37b5so4332885e9.2
        for <linux-iio@vger.kernel.org>; Wed, 16 Sep 2026 02:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789551899; x=1790156699; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mlvIWhHxBEziBE7U0OeSd/0yRYTGHP2RvC97KNNwMIM=;
        b=UZLSb1k05dP78zdfVGpisY9oAFhpWoCGbeS8KoAGEA8ewUFklmFuh2TSCQwO7D8UiX
         G6GDeKk1WwAd0xq/l8HCB4qAsyk53jDcjQO7tkLPCSAjCRI7azo7jI+eZBpton19mjBs
         k9dc+EVMxflSj2ItGCN36FvTK1sbHwUwybI7qBhwinzIsnPRhEMnt6U35OzrEiiKY+De
         Uz96mnCn32+iEIE6w4l9h6b+lahYa6qJToo4/7RUyKQxFpp2SqcUNBt0upvMeAzgzhil
         rcUPB7dzG76c7cdorV82MEn0IazAaNEw7NsAIzkw3CHUT+T3+yX1xRXfqCuBQFT97E9u
         25iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789551899; x=1790156699;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mlvIWhHxBEziBE7U0OeSd/0yRYTGHP2RvC97KNNwMIM=;
        b=Qcx0uRDxkVuLMRskXoaWPkZX9tPLotC6G+ocGv3QTxldXBrAIpUQh/n8jaIQwNQllD
         zdpyck0TG2ibC4vnxNhhZdAqHQpaTJwC++TM1KXZ4xGjVjsNBNffi7eHUrEPAoKXAqk3
         tQcC7VcaO9kIQzkZzy1ebYb+dC6+oVASejMySXJ3S8B4jRDy0yHeS/BQpTCuYff3LFgH
         vyPF/4YJTdiC6Kd1Stn7CuFOvlujyeys4ak0upEnuAxhEs63Inl9MZi/I91h1xR5pTDH
         UooYMuXaI7WyjgGCL510DloY4TYaBfeLxkwyQ4LcDx2a8Hd1OCgFSqJEbEAyF+OddQIA
         8ljw==
X-Forwarded-Encrypted: i=1; AKwUvBz5/aBkwBGPGagZwGawTHnwub04UqNDGfOm/8J84TLpNLlm98DnDcREgP3dla0Ia6DY6Fv4ODIt8Ek=@vger.kernel.org
X-Gm-Message-State: AFuF++mU3WT+vAeuqVvIQeSKXJOjmayLZHdSFyD6xWCqca61xFvoXhKX
	crhTpmOLUPlo+C17OCZxJqWTVwv/gYTbhdgFHWToib8Gviy72iNoxVvc
X-Gm-Gg: AYBFou2p+UlDc7DngCW94Mng7u27FGuIxD///kFV9cJXaO+1ufeWeHB95dCbAdZa/qa
	YVPyWvfFQzzi1FD5v/EnBrmZD7reXCDlnevKZ3lZPNxUKwIhg+zO1ZrFgp7fBICCCDnpRtBnEoP
	pT6uIlEsTqc25erPreTqyVqoIW7PFFQgawB+ooMrAjkEDFfdfqbngmKzRY7If1C9pA5L0h5Xgh3
	QYFoT1NStTlafrR6daVUvthk+fYLCC6IiZNkbuxVxutSm19OxP3fDZGFX+DiWbHilhdPHLHl+jP
	zMo2g/2oIHrH4KcV2A6jaez5Iv9T6hAUc0QjK7VENdNSvwhcJn7N3drwtDC/OujhjlSwFDHafsp
	byNZhW0NopdWRAG4zhw9FJERJCVC8MYGeMYBLOtOIsYHNmZDKUCFczLPyGAsq99ER6uKhmicUPJ
	u3Jpk3sQNa6pxK5oRz1sG5KmO0o/tXObq130B2h2Po3FLTbdHrSpUSXnGrq+6ON03zmZKWRETJD
	o4Q9MVo40gcPZk5xHeYJMTq1UqnAD6NzIfZRx8zRC+R+o6Ig0pku1XXgDwCbv7R/uR7YEa5v2ch
	b3zMz36mjAx12o/2AuQagM2VWZp9zpBUwgTLKtyHmq/kypXj93rKBJVd5Afbz0h6OzPdhH6trHX
	F0OR4d2/I6M29r8Im9qM2wGpykjbctU+iD0+FbcO4H9MerXTYB9tmobI10rcrzy3D9syztagBIy
	wcs41P
X-Received: by 2002:a05:600d:1b:b0:49b:9105:cdaf with SMTP id 5b1f17b1804b1-49f1d516a12mr35131575e9.8.1789551898435;
        Wed, 16 Sep 2026 02:44:58 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e83b02211sm68509815e9.9.2026.09.16.02.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 02:44:58 -0700 (PDT)
Date: Wed, 16 Sep 2026 11:44:57 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Kanak Shilledar <Kanak.Shilledar@axis.com>
Cc: "jic23@kernel.org" <jic23@kernel.org>, "dlechner@baylibre.com"
 <dlechner@baylibre.com>, Henrik Grimler <Henrik.Grimler@axis.com>,
 "nuno.sa@analog.com" <nuno.sa@analog.com>, "jean-baptiste.maneyrol@tdk.com"
 <jean-baptiste.maneyrol@tdk.com>, "robh@kernel.org" <robh@kernel.org>,
 "marcelo.schmitt1@gmail.com" <marcelo.schmitt1@gmail.com>,
 "andy@kernel.org" <andy@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "macromorgan@hotmail.com" <macromorgan@hotmail.com>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>, Kernel <Kernel@axis.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 7/8] iio: imu: inv_icm42607: Add accelerometer
 calibbias support
Message-ID: <20260916114457.000073ba@gmail.com>
In-Reply-To: <b58448efafcd27ceb2c924139ea97201b349b534.camel@axis.com>
References: <20260901-b4-inv_icm42370p-v3-0-77cc31642115@axis.com>
	<20260901-b4-inv_icm42370p-v3-7-77cc31642115@axis.com>
	<178874609182.3402141.6437933635539106261.b4-review@b4>
	<b58448efafcd27ceb2c924139ea97201b349b534.camel@axis.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 09:37:32 +0000
Kanak Shilledar <Kanak.Shilledar@axis.com> wrote:

> Hi Jonathan,
> 
> On Mon, 2026-09-07 at 02:54 +0100, Jonathan Cameron wrote:
> > > Expose IIO_CHAN_INFO_CALIBBIAS on the accelerometer channels. The
> > > registers are stored in MREG1, which can be accessed by the
> > > mreg_read
> > > and mreg_write routines. The calibration bias is written to
> > > OFFSET_USER4
> > > to OFFSET_USER8 registers in MREG1.
> > > 
> > > Note: The accelerometer functionality is tested with Invensense,
> > > ICM42370-P development board.
> > > 
> > > Datasheet:
> > > https://www.invensense.tdk.com/en-us/products/3-axis/icm-42370-p
> > > Datasheet: https://www.lcsc.com/product-detail/C5129967.html
> > > Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>  
> > 
> > Various things inline.
> > 
> > Thanks
> > 
> > Jonathan  
> 
> I will fix these issues.
> Thanks and Regards,
> Kanak Shilledar
> 

Hi Kanak,

No need to send a response to a review only saying you'll fix the
pointed out issues, it generates too much noise on the list. No
response means you agree with the review and will address it in
the next version :)

Thanks!

--
Kind regards,
Joshua Crofts
