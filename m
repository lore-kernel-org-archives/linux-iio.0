Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE00034DB61;
	Sun, 15 Mar 2026 12:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773577339; cv=none; b=WUix182DYqt3pbC9QQGgwbJzLRLl6Z3MfDUw7Mh5v9NCmHjvczGwHeueHS06cVTABb9tjpfUfJm6DjhfOJQICKGoSVgb29T2jjPZpbgp2bwk7zTobbBgOKBEXy+FZ665ax2lLxvb9qXqtoFHhLYnt7bkEWQMqDOYqutjS9oNPCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773577339; c=relaxed/simple;
	bh=iFMrSiF1E6TZOHC2YdaGWVULyXxbbWi331NDzuVSkgc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M9nAiHanEjfmcW0qlxE+Ydbr6fDchBPVWeP3OOOF+P4GrQsSF4PIhVj3MCQQksn7DTAFLhK1kfOsCD46ImtZBMwa+wkNGZ6ZlK0VnMiijfu98FNkAOEHgUDi/9KEDO2vtkMhXkSDuaDZdUQ5T8257GvmSQ65ONf40Y4Cc7xzG0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4F5NEWa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4F5NEWa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06269C4CEF7;
	Sun, 15 Mar 2026 12:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773577339;
	bh=iFMrSiF1E6TZOHC2YdaGWVULyXxbbWi331NDzuVSkgc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N4F5NEWawgZdbutjVvNpEOyJuuukrr2hOnzWj928EX9x3CfL/6dASyXvsKICJinWn
	 qYRpduGGn3duhguuTuTDwcFxhFeaHo3JS25ifFmP9QTgiObHe3ZnzRVsdkPENwRBwr
	 0Tj6D2N0VGg0+yOwJjWKeCaaXeiD2/gSgdaLcVJfKgEJjWhIJK0LF53+PBXS/AS8py
	 p5t3cmC20kCY4wFa7guOMus9dOpVfgzoELpiZN4G9Yd5D4cSeSc4tRTM/lmjYOM0lt
	 PLYWn2SFVHh4PqAYKhzDLLc0Hyfl4VtCWGortxG6YVve0Hqg0FBSx6bbvPy8f0Kjnq
	 axPOoxtzJ72Gw==
Date: Sun, 15 Mar 2026 12:22:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko	 <andy@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Nathan Chancellor	
 <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] iio: imu: bmi160: Remove potential undefined
 behavior in bmi160_config_pin()
Message-ID: <20260315122200.5b88b585@jic23-huawei>
In-Reply-To: <26ee13c084488bb66aec8e240e416e3e43f3b697.camel@gmail.com>
References: <fb653ed07fa99e3ebc51374bb367cba5712e4ca1.1773114154.git.jpoimboe@kernel.org>
	<26ee13c084488bb66aec8e240e416e3e43f3b697.camel@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Mar 2026 14:57:19 +0000
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, 2026-03-09 at 20:45 -0700, Josh Poimboeuf wrote:
> > If 'pin' is not one of its expected values, the value of
> > 'int_out_ctrl_shift' is undefined.=C2=A0 With UBSAN enabled, this causes
> > Clang to generate undefined behavior, resulting in the following
> > warning:
> >=20
> > =C2=A0 drivers/iio/imu/bmi160/bmi160_core.o: warning: objtool: bmi160_s=
etup_irq() falls through to next
> > function __cfi_bmi160_core_runtime_resume()
> >=20
> > Prevent the UB and improve error handling by returning an error if 'pin'
> > has an unexpected value.
> >=20
> > While at it, simplify the code a bit by moving the 'pin_name' assignment
> > to the first switch statement.
> >=20
> > Fixes: 895bf81e6bbf ("iio:bmi160: add drdy interrupt support")
> > Reported-by: Arnd Bergmann <arnd@arndb.de>
> > Closes: https://lore.kernel.org/a426d669-58bb-4be1-9eaa-6f3d83109e2d@ap=
p.fastmail.com
> > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > --- =20
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan
