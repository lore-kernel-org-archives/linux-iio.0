Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235FD37BE8E;
	Sat, 16 May 2026 12:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778934365; cv=none; b=q1wbFDXC6uxtfG0uar4ZKX8bhmwh+L0cX1eC+3cZfXop3mUCXvonKhS5rTw0+ARAY+dZr5iwjD2sEXwUTHQjkuNvRAxsVhtODUr48grRf7F1dRXNqDsqjIISbSKxgwvJh6H2dn1koLioKHwkeV6TZKAcRdKoyXTlrZ+b/qvMMlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778934365; c=relaxed/simple;
	bh=CzCLPKdxgmkU3KeGZzjbxbzlN8JlClx5u9Hqwg+QpMs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VJYmqIpk30DZlU/RjtTQZ4QyOyV5D6Kj9XqbdQGQX6hTymAgSw6/9N91l1vSb/JhBJb8pYZAqglmDZC1302NDb37fMhFMf8vC1pMO1gVLtoiLaxX+gsgtGLH+lOQKACDPHK+kpC/iS5ZP0JGoqlbjDnwBXrY9B2NxG9/Ns4OKVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sSTP2KtX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sSTP2KtX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A661C2BCB3;
	Sat, 16 May 2026 12:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778934364;
	bh=CzCLPKdxgmkU3KeGZzjbxbzlN8JlClx5u9Hqwg+QpMs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sSTP2KtX0vj/N8/ccR0A96c0BzqBuJAT5GwYEDzLpz9Zon2Vo3f+91FYw3ul/0yBT
	 0kw8wCFXOboy0TyT0Z7PV0iixBpIX3PhhGFsT/pB8z4u0YSpfKsjyHHa7w8vvTP10K
	 3aIgt925kDSPAOEKT4qbJvTR0m5ls2fC51OXFGDGPXQjJbaATZqmP2dqbkQCzgInuJ
	 xab9ble4+g3XR7sNrOs7UiCn9OOGk7DK3TUuz1PiFgOyko6UAWLt3aywXqZq+Py1Tr
	 UpsiaFKaCP6Hfp6tbVLVMMu/7mNdqeJsXD3fr8ITWKtxIBHRqV6wORo+WSOKb86v0o
	 KFFOkDjQxbTTg==
Date: Sat, 16 May 2026 13:25:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Aldo Conte <aldocontelk@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, shuah@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2 5/5] iio: light: tcs3472: move standalone return to
 default case
Message-ID: <20260516132555.64e27d62@jic23-huawei>
In-Reply-To: <1c87362a-bba8-45b8-a836-153f468815c4@gmail.com>
References: <20260512223215.25596-1-aldocontelk@gmail.com>
	<20260512223215.25596-6-aldocontelk@gmail.com>
	<agRfMWL9BughLT2x@ashevche-desk.local>
	<36ed59a7-8af7-4458-9e90-70ea251b389e@gmail.com>
	<agS70Dph8-zQT-e6@ashevche-desk.local>
	<20260515190517.70bb0ba5@jic23-huawei>
	<1c87362a-bba8-45b8-a836-153f468815c4@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 16 May 2026 13:04:13 +0200
Aldo Conte <aldocontelk@gmail.com> wrote:

> On 15/05/26 20:05, Jonathan Cameron wrote:
> > On Wed, 13 May 2026 20:58:40 +0300
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote: =20
>=20
> ...
>=20
> >=20
> > I would add for this that, to reduce churn it's fine to add the
> > struct device *dev =3D ... bit and use it in new devm calls. Just do the
> > remainder in the follow on commit.
> >  =20
> >>
> >> =20
> >  =20
>=20
> Hi Jonathan, Andy and all!
>=20
> Thanks for your reviews! they=E2=80=99re teaching me so much!
> If I understand correctly, I need to wait a week before submitting versio=
n v3=20
> such that other reviewers can comment right?
>=20
> I=E2=80=99d like to take this opportunity to suggest two alternative list=
s of what=20
> version v3 might look like in terms of patch order:
>=20
> First option does not consider the "=3D=3D NULL with !" patch and so:
> 1. iio: tcs3472: power down chip on probe failure (NEW precursor, bug fix)
> 2. iio: tcs3472: sort headers alphabetically (same)
> 3. iio: tcs3472: convert several functions to use guard(mutex)() (modifie=
d)
> 4. iio: tcs3472: use devm for resource management (slimmed down)
> 5. iio: tcs3472: use locale struct device * for remaining cases (NEW)
> 6. iio: tcs3472: implement wait time and sampling frequency (revised)
> 7. iio: tcs3472: move standalone return to default case (same as v2)
>=20
> Second version will consider it:
> 1. iio: tcs3472: power down chip on probe failure (NEW precursor, bug fix)
> 2. iio: tcs3472: sort headers alphabetically (same as v2)
> 3. iio: tcs3472: convert several functions to use guard(mutex)() (modifie=
d)
> 4. iio: tcs3472: replace =3D=3D NULL with ! (NEW, optional)
> 5. iio: tcs3472: use devm for resource management (slimmed down)
> 6. iio: tcs3472: use locale struct device * for remaining cases (NEW)
> 7. iio: tcs3472: implement wait time and sampling frequency (revised)
> 8. iio: tcs3472: move standalone return to default case (same as v2)
>=20
>=20
> What do you think?
Either is fine but swap the last two patches.  The wait time one is
more complex than that trivial cleanup so might take more revisions.

I frequently pick up the first part of series just to avoid people
having to keep sending the same unchanged code to the list (that I've
often forgotten about completely by the next version!)

Jonathan

>=20
>=20
> Thanks,
> Aldo

