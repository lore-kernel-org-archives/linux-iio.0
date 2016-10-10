Return-Path: <jic23@jic23.retrosnub.co.uk>
In-Reply-To: <20161010011321.jh5yovnjo7b5fuxj@wfg-t540p.sh.intel.com>
References: <20161005144650.50634-1-mika.westerberg@linux.intel.com> <9a919615-020e-e8e1-3e7e-fb5ab442a7f7@kernel.org> <20161010011321.jh5yovnjo7b5fuxj@wfg-t540p.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH] iio: adc: ti-adc081c: Select IIO_TRIGGERED_BUFFER to prevent build errors
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Mon, 10 Oct 2016 06:40:54 +0100
To: Fengguang Wu <fengguang.wu@intel.com>,Jonathan Cameron <jic23@kernel.org>
CC: Mika Westerberg <mika.westerberg@linux.intel.com>,Hartmut Knaack <knaack.h@gmx.de>,Lars-Peter Clausen <lars@metafoo.de>,Peter Meerwald-Stadler <pmeerw@pmeerw.net>,linux-iio@vger.kernel.org
Message-ID: <CEEE5EC6-DBC3-4A6E-B047-2D9A76D25779@jic23.retrosnub.co.uk>
List-ID: <linux-iio@vger.kernel.org>



On 10 October 2016 02:13:21 BST, Fengguang Wu <fengguang.wu@intel.com> wrote:
>On Sun, Oct 09, 2016 at 08:47:11AM +0100, Jonathan Cameron wrote:
>>On 05/10/16 15:46, Mika Westerberg wrote:
>>> Commit 08e05d1fce5c ("ti-adc081c: Initial triggered buffer support")
>added
>>> triggered buffer support but that also requires
>CONFIG_IIO_TRIGGERED_BUFFER,
>>> otherwise we get errors from linker such as:
>>>
>>>   drivers/built-in.o: In function `adc081c_remove':
>>>   drivers/iio/adc/ti-adc081c.c:225: undefined reference to
>`iio_triggered_buffer_cleanup'
>>>
>>> Fix these by explicitly selecting both CONFIG_IIO_TRIGGERED_BUFFER
>and
>>> CONFIG_IIO_BUFFER in Kconfig for the driver.
>>>
>>> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>>Applied to the fixes-togreg-post-rc1 branch of iio.git which I'll send
>>a pull request for once the merge window is closed. Strange this one
>>got through the autobuilders (less strange that it snuck past me
>>reviewing it ;(
>>
>>Fengguang, any thoughts?
>
>Sorry I find no log for that error and noticed 08e05d1fce5c is half
>year old which is not contained in any recent updated trees. Many
>things could have been changed/fixed during the time -- if you look at
>
>https://lists.01.org/pipermail/kbuild-all/2016-May/thread.html
>
>There are significant less error reports in May, which probably
>impacts late April as well -- at the time the commit is introduced.
>Then the problems are discovered and the report number is restored to
>over 1000 in June.
>
>Thanks,
>Fengguang

Cool. I hadn't registered it was that old.  

Thank

Jonathan

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
