Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B936B2417D1;
	Sat, 21 Mar 2026 19:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774120620; cv=none; b=J1/v6ydCCp0RPc3skgi67qymQFVYkbguqofBqB2QQMpSqYE1vyUz11zIZIXhukyG4aBCvnPcG/vFRqZbg24t3oYqusDiBLVeAcXErD9S744vcBIbioe04iR42nIMYwCypNbEO9Nz/4D6Ave3wkLedKk5jvZfvu8Spkn5NwB+WJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774120620; c=relaxed/simple;
	bh=2JkmzzfpRMk+WH5lJWJ1M3nnOTjji5h78gw9mpcX3ps=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hKlRGM7t6x33rfJqjmyNaGd1zmQ61bsmToM/9bASxTJjYEAgmwvFzx2DoNYK1bMXCUqE8GI4nki2BIxxWCQ/D5Qyt5RAL2TOtNtR1PgS+9IuSXV3ybhFH/HEdiO1f+NbV6rT98WrUzcFz3TQBKhFt+94kNqc3f5qJ2Yn5Mkwsgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ett7gg28; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ett7gg28"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C9FC2BC87;
	Sat, 21 Mar 2026 19:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774120620;
	bh=2JkmzzfpRMk+WH5lJWJ1M3nnOTjji5h78gw9mpcX3ps=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ett7gg28AXY53OJeaT/DY7T437bDeSYsBWl/8xpqA+403JKy5QyOLKazFjIQhOOwD
	 smEoB/g366y9843GSaWFIDAHPEjSnq3sy6KWAcK6lRHcA7cdf+4ArzF+ZPQWQkr6g7
	 Vet7I0XMuCe4zhSNVcwxpYii/W+IxkEDuvEpI7CQAtItoAqPGVbNHuZKXJszsyS09y
	 0jNwbCec47wtadAABLj4F5JiPvxQLs7qiTcQxOboqctiy5Jkr/QfZSfEolBToB1BxJ
	 CXNU5+07crORxK34KzI+g/AvVkZFwJnh2lKLCWJBHZbN+Tb8NEMw+g0VYQjRWMVmg1
	 3UC0o1WNGfbGQ==
Date: Sat, 21 Mar 2026 19:16:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shi Hao <i.shihao.999@gmail.com>
Cc: andriy.shevchenko@intel.com, andy@kernel.org, dlechner@baylibre.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 mazziesaccount@gmail.com, nuno.sa@analog.com
Subject: Re: [PATCH v5 05/14] iio: magnetometer: fix various spelling
 mistakes
Message-ID: <20260321191652.04406dfb@jic23-huawei>
In-Reply-To: <20260316090023.14691-6-i.shihao.999@gmail.com>
References: <20260316090023.14691-1-i.shihao.999@gmail.com>
	<20260316090023.14691-6-i.shihao.999@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2026 14:30:13 +0530
Shi Hao <i.shihao.999@gmail.com> wrote:

> Fix spelling mistakes in comments.
> 
> - follwing -> following
> - atleast -> at least
> - occured -> occurred
> - measurment -> measurement
> - rougly -> roughly
> 
> Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
Applied.
