Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793063508;
	b=RJU+0GfFltcRFDZwjlGW+CfQVJBZetmHwB8KYkm7hceRPkfWj5WpYvSt9RJ2m7JE79Gn
	 gjHQBve5g3mAOQtkePJnNJJQZP3UGoBb2KuaFwDKKPIYlAXnlxezOgHm/c4MU8Xj4BIqD
	 uD2M/855EZvWR0kneawgedt8b4PR3/N7kn3rZRdxo/ygh2Q4vmQ5fL5oTJKNjeU23sHFg
	 jnsqBOq5ymjNcLEI0pQcmUXHzHrASYSHfhkDMSwTNd6KWP90Ao8uc6MjXSr6OXVIAuU5S
	 r0AzSkqjrjpKrwDiQ08t2/Wm9uaXgfeGO948AiLGYVbfxjLYU+65xrKUn4SV4xNKZDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793063508;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=lQNU6hNGBy9jJbAi6r59f2PUJR0Koj1qckPlsZypSTk=;
	b=vNLN9QOD8HLyNyPTo1mNW9dhl94sMHwvbyexSOQklxSmyrI6Zu/1W5fTHFiSaADLiahL
	 SCthFrkcmADc60RUGc4AO0Ff0X0mn4yaWPkERwrLrZkFzL7itOYN7S5TWz/s02rBe9pFe
	 QPVGCELUaXbRFHoZWr90/oZXSzHjCocUs8CjDdZX3NHF1aTuR1Z40FYA5rAnqjp7QaTax
	 xchSRdHqGTbWy26iQOTVIV7cm/l25BCbzshwUf7FFa/VHHpX6Ng243iPBMJzeqbSs0eNB
	 DHY8cpxJjeSk+ZYGSFI9o5k9Vm/h/bY58tar2LHyDuDvXBJtSsclm+FyXEMPaQ3BXNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hVWh675o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696A5606A31A;
	Tue, 27 Oct 2026 01:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hVWh675o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 095CF1F01825;
	Tue, 27 Oct 2026 01:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793063508;
	bh=lQNU6hNGBy9jJbAi6r59f2PUJR0Koj1qckPlsZypSTk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hVWh675out79bGzP+eT+vTXlBvi8q+BuUtiK9jsImwMHkQGPl6iU1Ea6kIVEinF+4
	 DHFZgHTdaKKW9mZ0zV202B8oGQhyLBepn4BvN9sBBn7VrtnHzW50wyUuLeru5LNYPd
	 ovII4SKiUVAqkN0tif+j69bKabx4Iq3CkLozWjJ4t7a6y8BR7DRgggrKT73KP8KeNF
	 qERUGq34uJcm4jal/W96Id3kqJJp30EAsuUk+U026hWMKcyOAbcbpxIXWR7pcXTOiy
	 g6L8jL8g3Wex6kdkBjnIYv3K4Z7Vj+hNucD/3hvjdD6eCySP/tZrz6ir3o7WDBZEBX
	 Co8hjVZrgkFZA==
Date: Tue, 27 Oct 2026 01:11:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Nithishvelan M <mnithishvelan@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Nuno Sa <nuno.sa@analog.com>, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: iio: impedance-analyzer: ad5933: use
 guard(mutex) in ad5933_show()
Message-ID: <20261027011143.3bce4a32@jic23-hlaptop>
In-Reply-To: <at8iQhUDfDpkRxI6@ashevche-desk.local>
References: <20261026082828.652-1-mnithishvelan@gmail.com>
	<at8iQhUDfDpkRxI6@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Oct 2026 11:49:54 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Oct 26, 2026 at 08:28:28AM +0000, Nithishvelan M wrote:
> > Use guard(mutex) to automatically manage the state lock in
> > ad5933_show(). This simplifies the function by allowing direct returns
> > from each switch case, eliminating the mutable return variables and
> > manual mutex_unlock() calls.  
> 
> LGTM now,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 

Applied.
