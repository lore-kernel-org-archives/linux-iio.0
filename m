Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513113DA7CA;
	Mon, 18 May 2026 13:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779110639; cv=none; b=N+4obTFvOMcKe+8M+MPTBKa2q90SxUJNUJ4UQu/MbIuHw/9mCtQg0BbFDcuIH2fQpCCrHOJG362XsnkV7WKxuHq0zf1uUACOyhfwKq2hrLDOz3RujHQhoPYOffLFWNz163/iBCx/5JY9kBZRCXWzGkjZ8zblR/+zM0PsZdcQUIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779110639; c=relaxed/simple;
	bh=aucLeKBXYAv56Bk2QeUzMEX/qHWm3F3VmfTf3oDJ3L4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VqW5TQbxDhZM+/vHZDSfXdgwFtcln5FHo0UI0Xi0cuUs7NyCIzVh968/ncKzWjsD0KGWH0GbzUvzzvRE9tErawp8srfzK4xyoSZWQoNePMgYbKp+OTvMIG279IcTUBRcm98ke4KH14Vj9PvzImsbffTPizdffXw0KFtzxltV840=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTyUCLbs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTyUCLbs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 060D2C2BCB8;
	Mon, 18 May 2026 13:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779110638;
	bh=aucLeKBXYAv56Bk2QeUzMEX/qHWm3F3VmfTf3oDJ3L4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NTyUCLbs97OHTWLKHhxux1iUJmHp0xR//kqDpzAJjdf1r7ZxkrbpCJSHn4XsX/kF6
	 Ms3s2U2VGrFLobprZOYf+pBBRgHv8xrYpImZ4/3+xUIOFDar3U801CUMBXK8yRBPpv
	 Mmv6YVrRDUHK4lwt5412GCzpM02thf+unnLnyAo83jBVFqynZEgCVC93IDP2x0laHS
	 97G8LmHZMyTsOxp0tZpHa21UVDGtsr9MdoHOgOLb9TBVr265RqWfaNJXI6AbVma8A4
	 FVqtzCll3e34N5qrFKSszgIZcuZYoBs0jNOWmego7P0jEqXprVRh3OSgLtn7TkGude
	 pPz9gF1TMcDLg==
Date: Mon, 18 May 2026 14:23:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Felix Gu <ustc.gu@gmail.com>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: buffer: hw-consumer: free scan_mask on buffer
 release
Message-ID: <20260518142351.6dbb6c78@jic23-huawei>
In-Reply-To: <agrM1EMhiUJRc4Wg@nsa>
References: <20260427-iio_buf-v1-1-2bbdac844647@gmail.com>
	<agrM1EMhiUJRc4Wg@nsa>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 18 May 2026 09:26:00 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, Apr 27, 2026 at 07:11:39PM +0800, Felix Gu wrote:
> > The scan_mask lifetime changed in commit 9a2e1233d38c ("iio: buffer:
> > hw-consumer: remove redundant scan_mask flexible array").
> >=20
> > Before that change, the scan mask storage was embedded in struct
> > hw_consumer_buffer, so iio_hw_buf_release() could free the whole
> > allocation with a single kfree(hw_buf).
> >=20
> > That commit moved the scan mask to a separate bitmap_zalloc() allocation
> > stored in buffer.scan_mask, but left iio_hw_buf_release() unchanged.
> >=20
> > Free the scan mask in iio_hw_buf_release() before freeing the buffer
> > wrapper.
> >=20
> > Fixes: 9a2e1233d38c ("iio: buffer: hw-consumer: remove redundant scan_m=
ask flexible array")
> > Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> > --- =20
>=20
> For some reason this one did not get into my mailbox. Anyways, looks
> good and in line with buffer-cb. Thanks for fixing this:
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

>=20
> >  drivers/iio/buffer/industrialio-hw-consumer.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/drivers/iio/buffer/industrialio-hw-consumer.c b/drivers/ii=
o/buffer/industrialio-hw-consumer.c
> > index 24d7df603760..d1ab2cbf8c88 100644
> > --- a/drivers/iio/buffer/industrialio-hw-consumer.c
> > +++ b/drivers/iio/buffer/industrialio-hw-consumer.c
> > @@ -40,6 +40,8 @@ static void iio_hw_buf_release(struct iio_buffer *buf=
fer)
> >  {
> >  	struct hw_consumer_buffer *hw_buf =3D
> >  		iio_buffer_to_hw_consumer_buffer(buffer);
> > +
> > +	bitmap_free(buffer->scan_mask);
> >  	kfree(hw_buf);
> >  }
> > =20
> >=20
> > ---
> > base-commit: 7080e32d3f09d8688c4a87d81bdcc71f7f606b16
> > change-id: 20260427-iio_buf-0459b3fa3de8
> >=20
> > Best regards,
> > --=20
> > Felix Gu <ustc.gu@gmail.com>
> >  =20
>=20

