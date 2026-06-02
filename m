Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6057431D757;
	Tue,  2 Jun 2026 13:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780407151; cv=none; b=kEx3qebcYY02cRNuVJTc8Xip0cj92OjU5iJPFeFsE5Xf7+ZjUTpwPqId1npRZHoLCw81hAAF3ae1uxwqsxjLapRd8tlnEteeiKCgGj73yJnmCs/wTh9iHKBxU8Fdy8dSe4KN3TdGI9sdYgSBs7QgF4ulkmNh+pOPP75519CXZI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780407151; c=relaxed/simple;
	bh=EpmdDZaW2w1oLIhtYFRUFdYFlM+BSMFTrxUgXJIB4YM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RcWPxGyTqfcxxDXwM8H8MqjqLWcIRpJwqLw78uXqVms9ZqOokBpCPRzDFQoljtpjecYb4g8/9pMg+/18FrzTXoOBRC/alYcapID6+5GhGLEmi8gDL3yI76zjkeHB+IIZ9vZJrtAPEO990xIqZ3eeohwq6NEZmEG3C02/q5iSHe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFDA3AfG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFDA3AfG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E54921F00893;
	Tue,  2 Jun 2026 13:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780407150;
	bh=csQ6zV1wOFiVyJEg4MZcj4n4H7NA5KwNk3OlwGGmRA8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BFDA3AfGPKGx4RJapAnNS4ki2/cb1q6Xsl7j2JMi4RSxoCXPBxk133093A9lEgcUe
	 aPhyF4Are98y5aTZ4LsYpQ9D38U0K7gdhop38yUQX4+elKFc+yBJgLSKDOIoZYZQhK
	 BrnJXODdJmP9YRU3yNINmjNm19DAV79MlI6Neh3a46P/nD9w0BUsv/SQa6cNq5tbXT
	 oNXqmhMZVF/FjbfcNb81D66z07W9va5E/LA4Wgd40VZUkGGmMUjUCyEQGIjxUmi+02
	 UFmC08BdoxLWhb/U7u7fp02+B9uElKpkc59OGyRk+0xzlewlgMnB2z3DTXSYU66YkN
	 8VUaX8gMRqHew==
Date: Tue, 2 Jun 2026 14:32:21 +0100
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
Subject: Re: [PATCH v7 3/8] iio: dac: ad5686: drop enum id
Message-ID: <20260602143221.05e41650@jic23-huawei>
In-Reply-To: <20260524-ad5686-fixes-v7-3-b6bf395d08bd@analog.com>
References: <20260524-ad5686-fixes-v7-0-b6bf395d08bd@analog.com>
	<20260524-ad5686-fixes-v7-3-b6bf395d08bd@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 24 May 2026 11:17:03 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Split chip info table into separate structs and expose them to the spi
> i2c drivers. That is the preferrable approach and allows for the drivers
> to have knowledge of the device info before the common probe function gets
> called. Those chip info structs may be shared by SPI and I2C driver
> variants.
> Channel declaration definitions are grouped according to channel count and
> DECLARE_AD5693_CHANNELS() macro is renamed to DECLARE_AD5683_CHANNELS() to
> match the regmap_type enum.
> Use spi_get_device_match_data() and i2c_get_match_data() to get chip info
> struct reference, passing it as parameter to the core probe function.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
This clashed with Uwe's work on using named initializers for all
id tables.  Resolution was obvious given the problem was in the code
removed, not what you added.

I fixed it up.

J
