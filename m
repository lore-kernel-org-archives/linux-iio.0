Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC3C28DC4
	for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 17:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776620960; cv=none; b=EQJz92usMP5d9mpg9pfApZ0FeI3/RaMliMCWuTQEYfz5YjRRJa8H/Fe5a+XUFB1Ic6BYW3I8ZbkJten5ONP4yCrMxSvPLMcO2xwLaxvkCkp2SoOgaAOnY/0P8rAvegqnqFrgZh1eupSsAJ4jiS9knkBCC/D9hIvg8spPkZfc1oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776620960; c=relaxed/simple;
	bh=yJ7iXhGje1z6sgf7XtFNxZ2zfdlRID0zmFIc0JMqLmk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SI12db67QkToXEAViCi8A5bwzbjFNi+1A3AzkkUYn5mmT3LuyEAHymG1xfkeH70C/oZXoSmiKDl5CDzztTLQIkzJkAVfN7m60nHJMzoMPI2hCXJLxoYQu7/4++J79dDg8IshNqSGRDtumzo0L+Zd7iS+doTz9voVwH+t4N7Isq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lf9Ze9ys; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lf9Ze9ys"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B8DC2BCAF;
	Sun, 19 Apr 2026 17:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776620960;
	bh=yJ7iXhGje1z6sgf7XtFNxZ2zfdlRID0zmFIc0JMqLmk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Lf9Ze9ysQBFAhP+2y3jKP3Zm4oO0y6f4mKVWj/LY2NgpAjVRIjGjzBp4lnIYEX3ZV
	 sGYGX2l4hWT36JOrPq6pI3pwm6AANFLq7+y9jUQ/DG6I032lSmbqjJ28g4eDatRXkk
	 e/PDfXabosonPi/123CctbijYFBU6k7jWs+cp19z4P8A4besLz7gv0N697yATE/6II
	 8gSwgIuCXl+03i1TGMIastccqa7EC+LMg3q+XKs3ws6ldF5eJseZI83pBFcA82F1LL
	 tSFSSxzCIU0nGBr1b6iLvddqslZFjAU9/jfsSB5M/1WfVoYeqm0QnKYFyemc37b7YV
	 3xDah+2xxye7w==
Date: Sun, 19 Apr 2026 18:49:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nikhil Gautam <nikhilgtr@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v6 0/3] iio: dac: mcp4821: add configurable gain support
Message-ID: <20260419184913.091242ad@jic23-huawei>
In-Reply-To: <b9c61657-bed5-41ef-9dd3-e2fc04a4785c@baylibre.com>
References: <20260414170309.6151-1-nikhilgtr@gmail.com>
	<b9c61657-bed5-41ef-9dd3-e2fc04a4785c@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Apr 2026 12:51:32 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 4/14/26 12:03 PM, Nikhil Gautam wrote:
> > This series updates the MCP4821 DAC driver to support configurable gain.
> > 
> > Patch 1 fixes a spelling issue in an enum name.
> > Patch 2 performs a small refactor to simplify state handling.
> > Patch 3 adds configurable gain support using the GA bit and
> > adds support for writing to the scale attribute to select the gain.
> > 
> > The scale attribute is used to control gain selection. Writing supported
> > scale values selects the corresponding gain setting. The implementation
> > supports all variants of the MCP48xx family (8, 10, and 12-bit devices).
> >   
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 

Applied to the testing branch of iio.git

Thanks,

Jonathan
