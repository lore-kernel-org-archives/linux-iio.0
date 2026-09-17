Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C16539F190;
	Thu, 17 Sep 2026 02:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789613467; cv=none; b=bYQeXsPgrZHMNrBUsjca/reAG6btH9spHZlvBfapbg4VWPdiiiPe1M8+KEu3iNTjvMY7oaIHgXy0O4UePOWChQW6KwxugKRrgLMaAmSv+VuJplh5wvblJTiUQAgbHIiYwCOhszOZYfecQ6t6HNHh34thV1LB8SjYVx1fA+VifVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789613467; c=relaxed/simple;
	bh=dVsfaD5twGXBYRedmQv2hr4CmUj/sMq+rwxn/dCT5Qc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rk2ZDpJmc6wdkAcOn+SN0M+SDEyVIVn8sR/VTCNC4o+tH5FU9LAoAbZVWIe9RdbQH8KXtIzyGRlxe/OwVIDQBBerIoUlgZS/THIpKUjcjpeEnGznbg8im1hm6huKKUmTwPt9OTZWGIU/8LIoAI7dyWhpYi/bS9QprUR9hixp0jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TiEqp9iV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TiEqp9iV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C501F000FF;
	Thu, 17 Sep 2026 02:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789613444;
	bh=jbENKhjvnoUhQ9Fl7TONkFZKanQHQDJzBYnsMniCg44=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TiEqp9iVDWcbpUtcaj85NW6psXeoU5GqbOF06aPe7TTNviy/1gV24iYqwR4vz2IK+
	 ei8SMj/+wqwccbiis6ZVYSZy349yRZBPTXncqfOGDZv80l2YRH4aIz7Bf3COvJeLBB
	 qrnwjt4iatfqcJg+t/8ISKMhjkEW0Th3BGr++TMfwkw6xfj3+zw1PITXBAQRXS9eMd
	 Pvc9jUPS8u+Dz5l/rex1r3jrvBjCcRyrk2k5mbaaQqAVClb9KnlPJEVMQKA/TO/tAr
	 ckCmvmRNmvagt5IHopUhEKZwgMbK2XX3cT4Uc2juqTYmuo3YLL5aIMraUh+AojAJl9
	 6YQ4CBHOOA+oA==
Date: Thu, 17 Sep 2026 03:50:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: mdshahid03@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] iio: adc: bcm_iproc_adc: convert to devm-managed
 APIs
Message-ID: <20260917035032.006ab16d@jic23-hlaptop>
In-Reply-To: <aqilP8FSTmrLpqEQ@debian-BULLSEYE-live-builder-AMD64>
References: <20260908172359.30003-1-mdshahid03@gmail.com>
	<aqilP8FSTmrLpqEQ@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Sep 2026 22:54:07 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 09/08, mdshahid03@gmail.com wrote:
> > From: Mohammad Shahid <mdshahid03@gmail.com>
> > 
> > Changes in v4:
> > - Move the ADC enable error-path cleanup simplification into the
> >   clock conversion patch.
> > - Simplify the ADC devm cleanup action.
> > - Restore the blank line after the copyright header.
> >   
> 
> For the whole series,
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

Thanks. Added.
