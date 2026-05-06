Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FCC31D375;
	Wed,  6 May 2026 16:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778086656; cv=none; b=dzOuaOCRZDgGcbzP+BeuptH4N24HvuMBpGILNU+tMdxzgex7XnEFDcgWExO4GrcUElsdWy8/gDTHnZQG6r0M9BZdn4jVnG7vjKEkhixc6dkg/1jmfFgQr8zFfVZkVfqqo7R54MoqGSCf+tXLQ25U2Rl+6+X6BnZ9Sdkho2WG3qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778086656; c=relaxed/simple;
	bh=IQBPuuDSxjrhAcT3D6UOAuqt+nnGJmJTaipv+2nvprk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lw4/Qamz1IQCFo2hC1SO1IxUhWj3eCS/Qdtbndop/pY0QAU+cowkzvzKOLiv97iEciuGo3xIyqRb/4l3XtPBll5yrdIpOU/s06LDqfJGRT7aggVZCAkG8XmBwlDREvhb2NPBJ3XKSkEcBk7eYDkJoL/ANeP+lkehkRal8gFFokI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTVFhAOu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTVFhAOu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35F7C2BCB0;
	Wed,  6 May 2026 16:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778086656;
	bh=IQBPuuDSxjrhAcT3D6UOAuqt+nnGJmJTaipv+2nvprk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cTVFhAOunTM8bSUpnpnoXFFonz41LTWHAn5l3nmAOVHZkhcWRQjsllnKAG8otAAt5
	 uscAppRx0jZDOFQrMapy2XSbSTwPtrGMfto6Y+PBV57StBD4INH8WyzroyJWJ8S1nu
	 8NQyARx+44hneY6UTwV9RhrjVoiwxkF5xyQYlCux7qT/wA6Uw28iUrB8ROrVE8waXP
	 +LVc0h3jvHTPrsOa4fdF3DXHCzqlKvhDb0TBxybt5sXfbvu8/25CXuPwL2olLlR/1O
	 yT+kcRq+22S2QrS/7aYZDL82hmVc/2rZH1qNLm5vYDuLKX/x4+/lfUZWTPw0iTwB9b
	 KAaWrOSavPNOw==
Date: Wed, 6 May 2026 17:57:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Cc: joshua.crofts1@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 13/18] iio: magnetometer: ak8975: unify return code
 variable name
Message-ID: <20260506175728.5cd3c9ae@jic23-huawei>
In-Reply-To: <20260505-magnetometer-fixes-v5-13-831b9b5550fc@gmail.com>
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
	<20260505-magnetometer-fixes-v5-13-831b9b5550fc@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 05 May 2026 13:46:09 +0200
Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:

> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> In one case 'rc' is used in the other 'err', the most use 'ret'.
> Make the latter use the former, id est 'ret'.
> 
> While at it, drop unneeded ' < 0' checks.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
Applied.
