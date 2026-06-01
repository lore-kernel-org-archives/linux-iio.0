Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F21E38D687;
	Mon,  1 Jun 2026 09:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780305013; cv=none; b=RAbF49Rt8t143wa0aese8rnc/KBh7/Wb6/qQGBwl/ZHbRhMA0yLXg78GXW5I5dHDuTa5NLpSfzjJ7elQc6zbSDPn4Coi5gpNTm/tDfPTm6I2dRH6AF4aBOfbvOPRMLReDoBn6yDPKHLEntEoeYrzrl1xTA7fmhme/IhwZhREoQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780305013; c=relaxed/simple;
	bh=L5yXkUdf3kKjCt362UQP7/PAcBGlTzitbHmNKyolYKs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eyE8Z1ViMibCNlM+ASpwephtNPgscY5+a6/qxiEaz7OAqK0hAaqdy8i+OhHXE4LpanYZUmvbih2EL11rNsokA3nnKeaanpantjAMKRE/tT/tPV7ptt+gNW5ubWhaXAJOskm5jMZbAS/ii9RaL8jjOUzIToJuxVX7cyeW3Z/K2RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWUFdFkN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWUFdFkN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562841F00893;
	Mon,  1 Jun 2026 09:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780305012;
	bh=aw+wP5p72/+RO/EHoOg8FmATsz9AyqNuScxDeeCNxVY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JWUFdFkNmlYz8r7wSLwNzpazSG8lGPsh8CDvk2iXUcMiGj8trxCuFSoQm7w37diF2
	 4oeLD05dl5F7c8conUMGBJxyOYEkSIHAdPttQI4aiNJV+B1mDlGqZIuYmMVWGZLdPP
	 XBUw2esqz0WzmAh/s8Pb4K1/JnlSqJwknd33RVH0tuUBzaArDbKIwBnX+LwVpBDbCQ
	 hNT6G8qx/Sty+Bg2fo6N4JzQcDrrVdtgbkwgpow8SLkSSI4Sg//NSsdHJ+MnMyMX69
	 xUFuvexAxkA/rTjz69NMYOuXMTFVmm1kLJH1ap1KKg0sn8pH0SR3mtP4I0wI1y5oxf
	 kbqhpUQ90GCvw==
Date: Mon, 1 Jun 2026 10:10:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Cc: linux-iio@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, Igor Korotin
 <igor.korotin.linux@gmail.com>, Brandon Saint-John <branstj@gmail.com>
Subject: Re: [RFC PATCH v3 2/4] rust: add minimal IIO subsystem abstractions
Message-ID: <20260601101004.4346a477@jic23-huawei>
In-Reply-To: <CAO26r3QasDuUo2_7qrJfPtQer-UP6K6jzg9=RhDRT8OXN5BK-w@mail.gmail.com>
References: <20260524132824.54918-1-muchamadcoirulanwar@gmail.com>
	<20260524132824.54918-3-muchamadcoirulanwar@gmail.com>
	<20260528170927.65168836@jic23-huawei>
	<CAO26r3QasDuUo2_7qrJfPtQer-UP6K6jzg9=RhDRT8OXN5BK-w@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 1 Jun 2026 15:30:40 +0700
Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com> wrote:

> On Thu, 28 May 2026 17:09:00 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
Hi Coirul,

A small kernel review process thing.  You need to keep more context.
A reader shouldn't need to go open previous email just to find
out what code we are talking about. Take a look at other review
discussions on the mailing lists you are sending this to.
(though oddly this pattern has become a common thing in last week or
 so - hence I'm sending this comment a lot!)



> 
> > why .get() for this one.  
> 
> I used .get() because NonZeroI32 is a wrapper type, meaning we have to
> explicitly extract the
> inner i32. Since the other variants use a plain i32, they don't need
> it. I'll add a quick comment in
> v4 to clarify this.

Ah no need. That was my lack of rust knowledge.  You'll be helping
reviewers understand this stuff for a while!

