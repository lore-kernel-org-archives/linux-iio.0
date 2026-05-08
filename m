Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B42633A71B;
	Fri,  8 May 2026 12:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778243109; cv=none; b=AxRm7wH7JeUKkZ0YRSJtz1wKtNY2tDlCTPx8IEeBIDKIrbc2kO3GB+sr8ta6NKIfRKVLk6ci0OiSfboiKGk4askkFfsSzE+pJIfT9CmBAtMiKCQbcOekzqa1p2lv4xmMqXyuXK0pOuubeGrMat9goVG+lf8OVeDTnzoA0jeIwmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778243109; c=relaxed/simple;
	bh=zStWSOzJ/qw1WK9XSndyjbH8dr5rLSn3Pe1wlj9fzFI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=amANo+wcMEYL3G7pFdWQwF+u25TDXAc/OefnJOO25zGyJh9rpC2f1uGC8tqlTpr7OBs3uhKgezXCIPWduJbwfNmHPLvIk6u86FnJVznR5OnY6YhrqIq4L6lIJmQUNuF4RABzKb0CgefnOJLZv765UcI0tiOKDWNaAdCd2jBnirM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=snc3g3jl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="snc3g3jl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD1AC2BCB0;
	Fri,  8 May 2026 12:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778243109;
	bh=zStWSOzJ/qw1WK9XSndyjbH8dr5rLSn3Pe1wlj9fzFI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=snc3g3jlJxXqU4N8uC91feSNHlD5GJQEs8GH83WX5A79cwBZpPq6DarlafowzheZ7
	 y7MEBReTg7lK4MfCYzZblqHGBqvNw7R7eHzIpDTympfVRu+yI1tN7Q5jmt4b2n0aVv
	 DZk5MSDLd2TtRhvVtSCq+sF0x6F3tNDDONqgrB2CPOhZA/g3NFZbwioyb3ZLHIfIjl
	 kUyfesUM6fP5UbYgGDs6F66qyDQNiHsuXzz9lYXzss7xSuAUzpd1D3scTC8MEY4V0z
	 iaKP9lJt7Gnbfb7xCZaERf6jV6twmYQGBCZ1sTMUZgjzDC9GmQX5BmAPaV4e3Z7ZDi
	 mAlqOy0qqchHg==
Date: Fri, 8 May 2026 13:25:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: m32285159@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add myself as SCD30 maintainer
Message-ID: <20260508132501.04e6b92a@jic23-huawei>
In-Reply-To: <20260507170054.9349-1-sozdayvek@gmail.com>
References: <20260507172404.80435-1-m32285159@gmail.com>
	<20260507170054.9349-1-sozdayvek@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 May 2026 22:00:54 +0500
Stepan Ionichev <sozdayvek@gmail.com> wrote:

> On Thu, 07 May 2026, Maxwell Doose wrote:
> > The current maintainer's email is no longer valid and the driver is
> > being orphaned. Replace his entry with mine, as I am volunteering to
> > take over, and Jonathan Cameron has approved such.  
I dropped last bit as I'm approving it clearly via the SoB so it adds
nothing to the patch that lands upstream.

Applied.

Thanks,

Jonathan

> 
> I confirmed the bounce from tomasz.duszynski@octakon.com when sending
> a smatch-driven cleanup against scd30 yesterday, which is what
> triggered the orphan patch [1]. Glad you stepped up. Please feel free
> to drop my orphan patch in favour of this one.
> 
> [1] https://lore.kernel.org/linux-iio/20260506182931.494-1-sozdayvek@gmail.com/
> 
> Reviewed-by: Stepan Ionichev <sozdayvek@gmail.com>
> 
> Thanks,
> Stepan

