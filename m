Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254D5125AA;
	Sun, 16 Aug 2026 21:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786917487; cv=none; b=M5cRZdSu9mcCpIegUv+EoYIx+txpIxrAHdur2G3bjE0+KdwB/thRQIvHH25YTVHQFkhCoMus9GQp4w6XW1L3wt2nnhbq+/CbzoF/mb3K6ie3v/rJ5vNic/M1bH1KeIbSv2qU9a9aPlrloeK0/RvLsT7qbElCMe9ZJyTfFVECGMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786917487; c=relaxed/simple;
	bh=ycMVVx3V1yIYBJegnhOkCo5q7XUVQfXu3CRWOtMsVR0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=roWWshrhMtA7vPClFRcPMZ+45JpMfzE3+cTsQcAL1nKvV7rTrS0bw1S4r7Os6Jw8t6HiX4iyOv6C2OqlZA2F9q25bS7ocugy41NJ3MpCiuUaJn9pkqQtJ8yNgIZGF5oxWSKWN2Y++Zn3ycUmE1N59nPH81d/R/gtNbmQaMBu/AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WcjNmXBx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WcjNmXBx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 791AA1F000E9;
	Sun, 16 Aug 2026 21:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786917485;
	bh=c/gwN0oSHxpfoYlo/fFExAijvYZD5w9gXaTT7h5N7tM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WcjNmXBxma8RN9P9LvqoBANfYBysvanClLNULs5APikVSa5vSTGh5mNLJn2LV95Lp
	 PK/+M2IqhywfBMA+38ljgds762pH5bq9Gr/UTrCwwia7PbHF5Bo12BCgdkFjP5ZKki
	 t1juOQhrMrl7ZlwzCKK0Eme+mwlh9DZlThKgNKbikWhejVYr44svDIxZJWBif4RNvu
	 zzFZ344nq3eyxjfyI1aezUKj0763lN4dNgrNZ563QTREIpfV5YYXgXqOkim2IgzQBf
	 1dud3XbNqDIdqGSk80vgySoa6cabkMNvpBrJUZIgTMe7zPd8Q/tSeAw12aNVpyQYhE
	 ljK5kj4ixb19A==
Date: Sun, 16 Aug 2026 22:58:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Adinata Tan <adinatatan99@gmail.com>
Cc: lorenzo@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev, adinata.softwareengineer@gmail.com
Subject: Re: [PATCH 1/5] iio: humidity: hts221: report available values via
 read_avail()
Message-ID: <20260816225801.3fc685be@jic23-huawei>
In-Reply-To: <CAG442=sn1YnDGdVvfnj6ZaeLknN46EqhAdkYBBp-6AnrrnDGCg@mail.gmail.com>
References: <20260808090026.34187-1-adinata.softwareengineer@gmail.com>
	<20260808090026.34187-2-adinata.softwareengineer@gmail.com>
	<20260810010943.014d8db1@jic23-huawei>
	<CAG442=sRDMfdVZB5GY+f6Wud7Vx8xR3ORN0GWVRVV8NKLVX29Q@mail.gmail.com>
	<20260812060414.427f7616@jic23-huawei>
	<CAG442=sn1YnDGdVvfnj6ZaeLknN46EqhAdkYBBp-6AnrrnDGCg@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Aug 2026 19:40:05 +0800
Adinata Tan <adinatatan99@gmail.com> wrote:

> Hi Jonathan,
> Thanks for the input. In this case, we can proceed with the current
> implementation?
Busy week so sorry for slow reply.

Yes, that's fine and what I assume you did for v2!

Jonathan

> 
> > > For this humidity case in particular, would it be better to keep the legacy
> > > implementation while adding the new read_avail()?  
> >
> > To me it seems vanishingly unlikely there is any code out there jumping
> > through the hoops to read the wrong ABI element to figure out a possible
> > value to write to in_humidityrelative_oversampling_ratio
> >
> > So I think this is in the category of ABI that we can change as long
> > as no one notices.  For IIO I will also generally take ABI fixes on
> > basis we actually want to know if anyone is using the broken ABI
> > (and they very rarely are!)  

