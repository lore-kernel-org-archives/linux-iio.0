Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E98221DAE;
	Fri,  3 Jul 2026 19:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783105690; cv=none; b=lOvMxWXZuGtdln2v9ZJVr2aBRFKjawtmGJsylheLKlpLTqpMAtBaQis0E2tCMWGkEAR8Af+GpfR4acpdxEa3fzhKawgXUuZF36lTZrslx8g40SECeq8eagaScJ1bSkGJ2l/mg55w505HOtrvsnG0RuIanlPysG/k/M1Ul56KvgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783105690; c=relaxed/simple;
	bh=MmOPcXioRM7Aq1lIbKuat51WzLWlPfb3OndIxx38oiA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TayhB9AXjzYMtmAxLt+brB0mc63djzzkaFwP9XgGFeW3suMb0zo6VKaJDOmbn1Y2w9yo7CZ6trTJKqZFChbYX+MqiUAQL5zs9mgPK0LpOtlOH78J/yGafH3q0QGHklf7WGYhueeTaaPBjhpx+p8NOyvqF+f+v1d7Vj2ONGtCj88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mg8Mbz4j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mg8Mbz4j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F3481F000E9;
	Fri,  3 Jul 2026 19:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783105689;
	bh=0RF2OdUsZ2+bwMWnfQqVgwpZ23fuhA/xZSnwxuZidsU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Mg8Mbz4jprOhqxwR/KWZALt7YjHrR3D8wO0RAyqxqJef7g40WnOGx7XdwQQtzPxAc
	 Jt2+qxpnyCVotrnMVk8NAWkgLnDVq32TlrpwfmPdAYPXNVwoG0oOQFlQ2PZKijwLkH
	 Tlowvm8x3VP74DlvCyJg8NGzhncotBddxtCuMF0++1SbspFFLsbeaS+hz9qERiXXXE
	 NhSknvFoYZ46pIJWB9WnBf1+6USYB3iR9aYctcREP8riNcnHkr1q0WJ3WBI2c94ro0
	 zHnB9qEH/Kpneha7xcURkJ7767+/lHc6K6JdxbBq/8GfL/0GCIW46kdEEoqy+wDA/O
	 uurS92Ti+JUOA==
Date: Fri, 3 Jul 2026 20:08:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: dlechner@baylibre.com, lars@metafoo.de, Michael.Hennerich@analog.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: resolver: ad2s1210: refactor trigger handler
Message-ID: <20260703200804.60fd22d0@jic23-huawei>
In-Reply-To: <20260516152408.2047-1-sozdayvek@gmail.com>
References: <20260516-iio-resolver-refactor-trigger-handler-v1-1-25b11ba0155e@baylibre.com>
	<20260516152408.2047-1-sozdayvek@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 May 2026 20:24:08 +0500
Stepan Ionichev <sozdayvek@gmail.com> wrote:

> On Sat, May 16, 2026, David Lechner wrote:
> > Refactor the trigger handler to avoid use of goto in a guard() scope.
> > Ideally, we should not be mixing goto and automatic cleanup.
> >
> > iio_trigger_notify_done() was not part of the critical section anyway,
> > so is not moved to the new function.  
> 
> Reviewed-by: Stepan Ionichev <sozdayvek@gmail.com>

Applied. Thanks,
