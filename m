Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32C528643A;
	Sat, 21 Mar 2026 19:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774120674; cv=none; b=rZGzEre9CstHGZ+rv5yeDtfc/TGnISHa5sSxOsmiYo4htlGNejOnOCnh9bkGBrVb3qqMw7oU4aR6PcAZ62cz4eiW+gDmtoZPr+PwogdiEbkSrKe9UExfugOQ3xfDm05u4iXvDihJdXXd5+2k3fTHGpM2N627Ds0Jxgo5cVUiKkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774120674; c=relaxed/simple;
	bh=YVTVtYDXQk/iCviU8j5H2oCpO781V7ceK8BBr0iaz9w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d1DT/tqwAXH9q2/aaCTPU/5d+tjXnqhbEv2l4/+q/tUMDcj7w9Kd3JoNMc/oJ1GNrQScvO2WvAlzbqtAHb+JYF62lceMXNxkSg2NkplUVLZ5mvT3l/z+BMcmw85ixm6QbLXL85vJtazsYxYILKC9CcXzNVZ8oNX9RJIs07PMd5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZdgHC7ne; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZdgHC7ne"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65011C19421;
	Sat, 21 Mar 2026 19:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774120674;
	bh=YVTVtYDXQk/iCviU8j5H2oCpO781V7ceK8BBr0iaz9w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZdgHC7neS0PEJGTY4wAJ1D4uvzUSsz5DsscZHF1pLp90B7M6p0PogVuEUliUoR56Q
	 A1wiBcvKpQrrEQ1jXQblN7VQEAsVv+bgYDjL1pAROnFEvple36wzT94v5L/1kCy6Re
	 F6XDFlF2cbd2OnV3gB2Xw/7xkCTReks7Ajt5FfzRXu/4hWZpVYASlkVvaOsfl/fvNL
	 Zw6bAfl1RMJRWBdHb8cnnzJAcdGljLhhc77/88Js2FJ1ME693WMGmaQyaHBnMxthDZ
	 wUm9LXTucUistYNWvYtMEC/A81rScg3jjuV3mNCNb4j5lr5Kn7PRbjNESE0zl4urLS
	 s9RGP+dHO+gCA==
Date: Sat, 21 Mar 2026 19:17:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shi Hao <i.shihao.999@gmail.com>
Cc: andriy.shevchenko@intel.com, andy@kernel.org, dlechner@baylibre.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 mazziesaccount@gmail.com, nuno.sa@analog.com
Subject: Re: [PATCH v5 06/14] iio: pressure: fix spelling mistakes in
 comments
Message-ID: <20260321191746.7fd964fc@jic23-huawei>
In-Reply-To: <20260316090023.14691-7-i.shihao.999@gmail.com>
References: <20260316090023.14691-1-i.shihao.999@gmail.com>
	<20260316090023.14691-7-i.shihao.999@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2026 14:30:14 +0530
Shi Hao <i.shihao.999@gmail.com> wrote:

> Fix several spelling mistakes in comments.
> 
> - opertion -> operations
> - transfered -> transferred
> - usng -> using
> - externaly -> externally
> 
> Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
Applied.  Note that all these had to be done by hand. 
I haven't taken the time to figure out why.
