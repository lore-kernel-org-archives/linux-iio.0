Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F761FDE1E;
	Tue,  4 Mar 2025 23:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741131263; cv=none; b=gdUSRUHBpF2EWQf+Dgc1eqfG/hsYuhzR60OTb6bxpn64MRFrIH8Fmm4FLKKjWizAHMpYt69Qpu7FFc2lEoZmnAWlzEez/zaljNO9aEIEEzpgvGEsUzD1dsuAgTpAZ8d9lDpuzHH/bRwLWpVurQYhaZYcebxkx42UShbPD6zMECA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741131263; c=relaxed/simple;
	bh=kM8RJDowmej9xcgCwmrS/qQgZmPIdRYBJAJSOmBcdMs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YbrO7EEO286MDtA8OHbtfoeGasxs1Ss7UAPqxjhZCAwbRuF4c9iZ2wQ+Mhg1Ym/D+Ekcw6tyXW3a3gdwsFRMZPkRfdFLPZUWTuBH2IDIVgY1UIglv9dqDAT4laZrATXyrEkR7B5AGt3jj/tjYYknmJcNYUEwxTGVb5u+Ww7YalM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Od8/Mxcf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Od8/Mxcf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 520A5C4CEE5;
	Tue,  4 Mar 2025 23:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741131263;
	bh=kM8RJDowmej9xcgCwmrS/qQgZmPIdRYBJAJSOmBcdMs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Od8/MxcfJ6kZwxduWn4hcyAxjJKkF/DV8XXU8Y406vC2pgpZ2KriX1ZZETn49/tTk
	 wf1ykSLbO1rws184xC+J3wv3VGFUuxdnjZZq7+x6IBFyMpzlS60IvPVBojeIM8z+va
	 ecJmwJX8TlzRUN/pga+zx85PsjwJ6heMRvp9y5LCqgfUvi5eHexxxzZ7Nis+Dg+3eA
	 aP7cFUqWnjoiwx/g9dxEckaAMkN4Wd3kb7BYSLpeBofr8SyZojOjEzy8MTzJc4DNDU
	 qqzyxG8pcmSmsJYt1dk0PaUKoG/G44SBhfVFJnMF+KlhJ7clhwU4I9VNr96dU+rkOu
	 IXcVB1YYWkyqA==
Date: Tue, 4 Mar 2025 23:34:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Sam Winchenbach <sam.winchenbach@framepointer.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 antoniu.miclaus@analog.com, lars@metafoo.de, Michael.Hennerich@analog.com
Subject: Re: [PATCH v2] iio: filter: admv8818: fix range calculation
Message-ID: <20250304233411.3fac7c69@jic23-huawei>
In-Reply-To: <Z7crV0DV1Fq7wE1Z@65YTFL3.secure.tethers.com>
References: <Z7crV0DV1Fq7wE1Z@65YTFL3.secure.tethers.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 08:17:11 -0500
Sam Winchenbach <sam.winchenbach@framepointer.org> wrote:

> Corrects the upper range of LPF Band 4 from 18.5 GHz to 18.85 GHz per
> the ADMV8818 datasheet
> 
Hi Sam,

Just a trivial process thing.  If you are sending updated code
and there isn't an obvious reason why when someone looks at the
old patch set (e.g. no reviews asking for changes etc) please
reply to that.

At times where reviewers (such as me on this occasion) are running
way behind they might look at wrong version otherwise.

Jonathan
