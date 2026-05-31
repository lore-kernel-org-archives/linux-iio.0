Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9952417D1;
	Sun, 31 May 2026 14:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780237788; cv=none; b=ajVuq95m9ooi/jA1kxzFUhyo0x5WS8GhRYKE0MPIhfylMWNwDWZ1ZbpAwo0unnJKVv93pmH5fxYsa0fdXn6zsKOSVjNhOaqNN5wSyYcjK0yQXQVT2UWmRkV/ZH+YcoIof98tHshIW9opss0U3WGESPUxmUW95vhF1Ko+0h7Jm+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780237788; c=relaxed/simple;
	bh=VV+bvLBPyzWCAES1xyY05y7SItkM62ijNhwMrsYrA/0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nZzCVlI3BkV6HxlVw4uaOhLQ6WOH2ExvUT+mmaawO7jCdGLO6WiAlSqO1PJtwWXUEJaoh+W7wAdhj6IBFiTKpuNSTiY26JMaP7B29xEXnl11CMm2zsQWqp51F/xWZtROAvBCuB3j9ah4stRBa6RegtbSDLE6H5WXZ6B8rwqGUnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBxo0UwA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBxo0UwA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7987B1F00893;
	Sun, 31 May 2026 14:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780237786;
	bh=r7NnKiSSL1BrIqnvrmeynUlYX1CC8XKVHjN623Vs+Ys=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZBxo0UwA2UGJPSr92/pnG3OniNVPr1gUffFr8PYG2PX6/xThvh5faInRrQhTK4nMu
	 jtyBOKNKJLSj8cp7f+hrpLkpaCaTi96GnBEbe2lKhA6r9SanmjlxG7oBu3e2a8NMSn
	 37jd5KFoM4fvISkfn2YCJxelwewAlAWJFzikYnmANkQonMsmparQY2eHsCFKYCCMZK
	 OR0zPhxo/kTDXCdMxL7P2JGVa0DlVAAUR/mFIZ/D4Uh3k9Ko0ta+06iN9WRCPR92ww
	 DEYvTSz59PDgsV6R+HR1vQtFppj/IZNloFz4aksELnq1jgkubghkkNmABOnYFa4+cB
	 sqRaCQYN6FL9Q==
Date: Sun, 31 May 2026 15:29:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: SeungJu Cheon <suunj1331@gmail.com>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, apokusinski01@gmail.com, me@brighamcampbell.com,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH 1/4] iio: pressure: mpl3115: convert probe to fully devm
 managed
Message-ID: <20260531152937.13aaf38c@jic23-huawei>
In-Reply-To: <CAGwK=3oJ1EhcC9uA0dufvCfkEfok2vx9yGYCO7iy22gkYW-=5A@mail.gmail.com>
References: <20260530113938.171540-1-suunj1331@gmail.com>
	<20260530113938.171540-2-suunj1331@gmail.com>
	<20260530161048.0e2ce1fe@jic23-huawei>
	<CAGwK=3oJ1EhcC9uA0dufvCfkEfok2vx9yGYCO7iy22gkYW-=5A@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 31 May 2026 19:49:40 +0900
SeungJu Cheon <suunj1331@gmail.com> wrote:

> Hi Jonathan, thanks for the detailed review.

Hi,

Small process thing.  When you agree with a comment and don't have
follow up questions, then crop out that part of the email.  Save any
acknowledgement / thanks for the change log section in the next version.

That lets us quickly see if there are questions.

If you have no questions or follow up on a particular review, don't reply
at all!  We will see the result in the next version anyway.

If there was anything in here that needed a reply, I missed it!
Jonathan

