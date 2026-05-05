Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199DC41325B;
	Tue,  5 May 2026 12:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777982819; cv=none; b=JvlOjVHFm5cuRvBEItW2GBp7kddR86eyCjYga27NOTWbPa3KOUOzrkuUw2k6c5WapHyjUatfVQah0Dr25Bo0ISmpubHguudNmN3ezJKuJ96Zxa1txnRzol0U5R5hGyZ6POGQ05g36uV4jlxQWzzpG7yTvtQoJvpCYLag6U3eapw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777982819; c=relaxed/simple;
	bh=dNIPiMNeE+uSsbeyL67D/p9s8hYZuqctUYnLWnxIC2k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qZHU/oMkwUUFAJ4zeVzfri6V/jwH+bEuyAlPhAr0010WR0bQ7e/Q/6JsVG1Fw3L8A08HChvAHFwV4OhiJlWss7Ys+FV5FBH4KW+NzRpS4iW0Ik1irB1HhskIy5pck88QoMiAFMmMaXmfPiCPY14n7DgeiAiTpSpmPfOumGR5tpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J47tYW6y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J47tYW6y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF7EC2BCC9;
	Tue,  5 May 2026 12:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777982818;
	bh=dNIPiMNeE+uSsbeyL67D/p9s8hYZuqctUYnLWnxIC2k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J47tYW6yl3BLPljduP47jAqDfreUytGWER/fExEIKnQ6AxPtHDMZESjwBzMwW8VAD
	 B2mR3GA1OBs0zQUiP78W+/HdJhTQ8xxk8uSn2FWiZ2F6TtFJ80yKHCNabT61PdCK/j
	 EY+rOq0+ufVjtAigedel1nV9CiRSy7puGn8b2ftF7KkYIC89nwpVelpMDBtDlM4IMl
	 NmOwHrKLyU/luLfNABcjeOHNNVvm3ppRlTdISoW5eQRRu3UHTBvC88gkmdxRE375vs
	 SlNTPWYlnJz6G4TPTMS4yws75KZreBmypAfpAZXPJuod0OMu/kk2kyJbpeaJTGea24
	 9NjnwG28NjXNw==
Date: Tue, 5 May 2026 13:06:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stefan Popa <stefan.popa@analog.com>,
 Jonathan Cameron <jic23@cam.ac.uk>, Greg Kroah-Hartman <gregkh@suse.de>,
 Michael Auchter <michael.auchter@ni.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Andy
 Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v5 12/12] iio: dac: ad5686: create bus ops struct
Message-ID: <20260505130649.240a133a@jic23-huawei>
In-Reply-To: <20260501-ad5686-fixes-v5-12-0b2f45488418@analog.com>
References: <20260501-ad5686-fixes-v5-0-0b2f45488418@analog.com>
	<20260501-ad5686-fixes-v5-12-0b2f45488418@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 01 May 2026 10:15:05 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Create struct with bus operations, which will be used to extend bus
> implementation features. Auxiliary functions ad5686_write() and
> ad5686_read() are created and ad5686_probe() now receives an ops struct
> pointer rather than individual read and write functions.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
Patches 5-12 look fine to me subject to the things Andy
pointed out.

Thanks,

Jonathan
