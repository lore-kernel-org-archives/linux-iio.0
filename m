Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB38117A31C;
	Sat, 14 Feb 2026 19:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771096174; cv=none; b=JqgbgX7ngn2rLngWK/LIZfZFFLLac9478ZUUjR144UeFPTRRIkdWbsJfTU7nUAJu6vJN+g0IO3LZ/+h18GHGrqlGfRMjkvh/AqSBaC0WNHmH+Fq1Ov6VKCz2su5NE5AT2FSKlr5HeEzv4J1O1uYas9hSCkkSo+hNG5+b+06KFgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771096174; c=relaxed/simple;
	bh=FpWW/sMH+DYxj2g93Wv3oeYe5fQIP539b1vyEylG1T0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WhA+ui49z6rA66Z1yMHSAqG+IyVYN/0uZWc4HhMfcWvHadP8BcLUcqdEa6ZY2u2TrV9qWcGD0LX9QQW5SVXlS3/I7mMzhrruhtet7smaTABbViYUxbw0z17Ufs7XUAjMMVUfQ1dV5uiOazIN5KP9XuYJ7Am8cSAcwcH3UvHGmkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffr/TUcV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffr/TUcV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC388C16AAE;
	Sat, 14 Feb 2026 19:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771096174;
	bh=FpWW/sMH+DYxj2g93Wv3oeYe5fQIP539b1vyEylG1T0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ffr/TUcVsbdf9GGdQZJ8SsmfCV5ZEUGPsn++VxTXb84k2n1caDLGOpbJ/q97Zn3e/
	 yewdA/8apaNx1qlyHjbojEy0TfSKkEl37/IrbmVoAgoJZiJB9o0dwocK+zbPMhqC1z
	 MQ/VdTX1raq/6SS75CtAXVzAL2z/p8wEn0jOBOD0zQ3qaIdxcQ1EK3tHmeeAi3VE3c
	 fb/TIAQRGaowKO4Nz1HdyYoI2QGcgewVSCqKlgAe3SsY1K6wQ9li8DGhuswuNw4o9d
	 FuzGmhQ2wRhdhhwQzgKP9uUYBd53UlaCnvkErT2/1cLd8+FyVttMLsOwdgQ6e/OxqB
	 L+2Ey1hsMMApQ==
Date: Sat, 14 Feb 2026 19:09:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: light: gp2ap020a00f: Correct return type to int
Message-ID: <20260214190927.54031ab6@jic23-huawei>
In-Reply-To: <20260211200654.25648-1-ethantidmore06@gmail.com>
References: <20260211200654.25648-1-ethantidmore06@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Feb 2026 14:06:54 -0600
Ethan Tidmore <ethantidmore06@gmail.com> wrote:

> The function gp2ap020a00f_get_thresh_reg() can return -EINVAL in
> its error path. Yet, the function has return type of u8. Add error
> checking for gp2ap020a00f_get_thresh_reg() return's value.
> 
> Fixes: 5d6a25bad035 ("iio:gp2ap020a00f: Switch to new event config interface")
> Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
Ah. I forgot to check for a v2.

See comments on v1.

Jonathan


