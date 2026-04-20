Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05163A380B;
	Mon, 20 Apr 2026 13:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691284; cv=none; b=Gi8hAgqgskCzlQ7siC9ropv7uOVzsnC6Evm2Tu5TV+oGnOlWQt2R27kVEYY5ENrvSQvOHOljwv0Lw/NJZ07kCxFoXRFrquXmB2S8JP9hDdKT9TVzpZrWOGKjC2P/xWNEpZ92n6OTn6TLhIhP6VJhkIWQ0/KM8vo/H40Y+tvEyLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691284; c=relaxed/simple;
	bh=ljvyhzT6Nvtw50hqX+gA305HATW22mofXgjTthntcB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oThhgOt2xtTukYwIYKMQZnP1XKkosslIiip/E+zq5PdcIHUeU9NCqOc8tkDo15RQCVyJ5Guj6DfLdarDkM/kOOdTtXJ0+CNV6HDBBDMOaD9jk+ZKQ7KadylJjQ6HYknks4Oo+/nl03nise/X9bzEkVhLnI7X9IOtno/8qYKevhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrjuQrpF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrjuQrpF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33DBDC2BCB6;
	Mon, 20 Apr 2026 13:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691283;
	bh=ljvyhzT6Nvtw50hqX+gA305HATW22mofXgjTthntcB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GrjuQrpFL4qk1iVWHaZ6gqw77psk84SfFXOTJupaMaVy3w6jhYXuGsNkKMzfe+5UU
	 Jw+t6I3I5c9XW/fNeiegrqvkCA/xwP8CmHUNjQAK16L1cJK5I4ntnNGtZOCju+29Ef
	 z+19KYoIDFMaX+e7DR65RLDOH2qUF5Q/QPSGTF+Qm7kAB/clDz+ptMV4whoIF93XHR
	 SKti8P1FImLHLgT3XpGIxFEZCs/A6+z+MYvvxjxBegz91+pAs2865FWFbrUs03IpH0
	 5pA7t1OMII3dy7nVqEJhIDUff6EHLugO7hTX0QGRmOlV3FwKD+E933KbXufW4nCojO
	 SmAeXMAwnJpMg==
From: Sasha Levin <sashal@kernel.org>
To: Fang Wang <32840572@qq.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 6.6.y] iio: common: st_sensors: Fix use of uninitialize device structs
Date: Mon, 20 Apr 2026 09:21:04 -0400
Message-ID: <20260420-stable-reply-iio-st-sensors-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <tencent_B4E5A4D17E67F7C7096F7BF8A4C701223008@qq.com>
References: <tencent_B4E5A4D17E67F7C7096F7BF8A4C701223008@qq.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Apr 14, 2026, Fang Wang wrote:
> Backport of 9f92e93e257b ("iio: common: st_sensors: Fix use of
> uninitialize device structs") to 6.6.y.

Queued for 6.6, thanks.

--
Thanks,
Sasha
