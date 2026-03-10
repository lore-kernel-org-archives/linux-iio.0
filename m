Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8AB3C5559;
	Tue, 10 Mar 2026 16:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773160167; cv=none; b=PrqP/ROzY74FvKSWGKA2lqEWv8geMsUcHliaB5pHEXChHwIn42SHrj54L6H7ETeQQEtj7k/uYC68lCaT4Pl9odyH9AjuF8zTU0sTxbMeY/nXTd26j8mD9DkMzvBzKiAadTbXYeg5tGiMptfTwAjz7WDhiKahToFSHUjZ631H9Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773160167; c=relaxed/simple;
	bh=VsaDX79DuCFmJN7u+hlFMdw7qYI7x3yL+W9kJANC3Yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KxNV1GDnFPuUZ8jJg0O8SQP3eRF2Fx4vKR6mnKO95QuDEv/38eOuBbwM+oiXtwPlsXHbZ6DES0Mso2KR9hH8+ba+6042lYgxRAXkREpTC8cHUeZ40+P/BWiZNY2weGceJb67L9TAoW04B6dHhSauomFG/Hrdvq2lrGalsbiyCuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddEdFT/O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddEdFT/O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D413C19423;
	Tue, 10 Mar 2026 16:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773160167;
	bh=VsaDX79DuCFmJN7u+hlFMdw7qYI7x3yL+W9kJANC3Yc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ddEdFT/OhR6eQCYrejEyEQ8ICI2cOMwnlqUf/xQbPhtnL2LrMY24tanJW6dHcDgPn
	 h7FW/zJLU0+jfiEAk2bek9rflyyqed+NTJb536XLIKrHBB/Sz5A+c6E4SUeKbqF5vM
	 cyhtGWUIgfX8bnJdFx4+j2hT+XLkACLIsDIH1I7X+K5OUXMpDOA6dzwJR0Ym8VARGo
	 jTqj0HkSiNoJwph/nfgsU1V4qPk+umOimKNDDbrCHvVfAWTjhYzLAfbrXA3M7DQqVz
	 rTEzl+aTFub5Ai1TZEt6POlDxDIda2JV2DsLUxefEERtzU0/yQM/8LoIpep6R2EhHa
	 cFlNbsWfHQPxg==
Date: Tue, 10 Mar 2026 09:29:24 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Nathan Chancellor <nathan@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] iio: imu: bmi160: Remove potential undefined behavior
 in bmi160_config_pin()
Message-ID: <iuky6xrhgkfrufvllvbqb6rfis3du7ow5rnh2nkamdupsvpkh5@us6k2bcmuzma>
References: <fb653ed07fa99e3ebc51374bb367cba5712e4ca1.1773114154.git.jpoimboe@kernel.org>
 <abACMNYNE5tpr9ZB@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <abACMNYNE5tpr9ZB@ashevche-desk.local>

On Tue, Mar 10, 2026 at 01:36:16PM +0200, Andy Shevchenko wrote:
> On Mon, Mar 09, 2026 at 08:45:45PM -0700, Josh Poimboeuf wrote:
> > If 'pin' is not one of its expected values, the value of
> > 'int_out_ctrl_shift' is undefined.  With UBSAN enabled, this causes
> > Clang to generate undefined behavior, resulting in the following
> > warning:
> > 
> >   drivers/iio/imu/bmi160/bmi160_core.o: warning: objtool: bmi160_setup_irq() falls through to next function __cfi_bmi160_core_runtime_resume()
> > 
> > Prevent the UB and improve error handling by returning an error if 'pin'
> > has an unexpected value.
> > 
> > While at it, simplify the code a bit by moving the 'pin_name' assignment
> > to the first switch statement.
> 
> Thanks!
> Are you aware of this: https://bugzilla.kernel.org/show_bug.cgi?id=219192?
> Perhaps also needs to be addressed? (I haven't checked if it's already done
> or not.)

I'll be out the rest of this week, but I'll take a look when I get back.

> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Thanks!

-- 
Josh
