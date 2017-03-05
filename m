Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:14388
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752383AbdCEQHS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Mar 2017 11:07:18 -0500
Date: Sun, 5 Mar 2017 17:07:04 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        outreachy-kernel@googlegroups.com, linux-iio@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] staging: iio: adis16209: Group similar
 macros into enums
In-Reply-To: <1488715674-22836-1-git-send-email-narcisaanamaria12@gmail.com>
Message-ID: <alpine.DEB.2.20.1703051657050.3052@hadrien>
References: <1488715674-22836-1-git-send-email-narcisaanamaria12@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On Sun, 5 Mar 2017, Narcisa Ana Maria Vasile wrote:

> If the macros are related, they should be grouped into an enum
> for clarity.

You can probably find more opportunities with this using Coccinelle:

@@
identifier i,j;
constant int c;
@@

(
  #define i c@j
|
* #define i c
)

This says to highlight all #defines where the named value is an integer
constant, and where that constant doesn't have the form of an identifier
(c@j).  The latter is needed because Coccinelle considers anything in all
upper case to be an integer constant too.

This will give a lot of false positives, but they are easy to ignore.

Some of the false positive could be gotten rid of by defining c as
follows:

constant int c : script:python { ok(c) };

The at the beginning of your semantic patch, you can define the ok
function:

@initialize:python@
@@

... definition f ok ...

ok should take one argument which is a string and should return a boolean.
You can for example return false when the string begins with 0x or when it
is a number bigger than say 10.

Really what you would want to do is detect the case where a bunchof such
#defines are next to each other.  Unfortunately that is not very easy,
because Coccinelle looks at each top level thing, ie each define, one at a
time.

julia


>
> Signed-off-by: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
> ---
>  drivers/staging/iio/accel/adis16209.c | 84 ++++++++++++++++++++---------------
>  1 file changed, 47 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
> index 8ff537f..706e119 100644
> --- a/drivers/staging/iio/accel/adis16209.c
> +++ b/drivers/staging/iio/accel/adis16209.c
> @@ -104,62 +104,72 @@
>  /* Operation, system command register */
>  #define ADIS16209_GLOB_CMD       0x3E
>
> +#define ADIS16209_ERROR_ACTIVE          BIT(14)
> +
>  /* MSC_CTRL */
>
> -/* Self-test at power-on: 1 = disabled, 0 = enabled */
> -#define ADIS16209_MSC_CTRL_PWRUP_SELF_TEST	BIT(10)
> +enum adis16209_msc_ctrl {
> +	/* Self-test at power-on: 1 = disabled, 0 = enabled */
> +	ADIS16209_MSC_CTRL_PWRUP_SELF_TEST = BIT(10),
>
> -/* Self-test enable */
> -#define ADIS16209_MSC_CTRL_SELF_TEST_EN	        BIT(8)
> +	/* Self-test enable */
> +	ADIS16209_MSC_CTRL_SELF_TEST_EN = BIT(8),
>
> -/* Data-ready enable: 1 = enabled, 0 = disabled */
> -#define ADIS16209_MSC_CTRL_DATA_RDY_EN	        BIT(2)
> +	/* Data-ready enable: 1 = enabled, 0 = disabled */
> +	ADIS16209_MSC_CTRL_DATA_RDY_EN = BIT(2),
>
> -/* Data-ready polarity: 1 = active high, 0 = active low */
> -#define ADIS16209_MSC_CTRL_ACTIVE_HIGH	        BIT(1)
> +	/* Data-ready polarity: 1 = active high, 0 = active low */
> +	ADIS16209_MSC_CTRL_ACTIVE_HIGH = BIT(1),
>
> -/* Data-ready line selection: 1 = DIO2, 0 = DIO1 */
> -#define ADIS16209_MSC_CTRL_DATA_RDY_DIO2	BIT(0)
> +	/* Data-ready line selection: 1 = DIO2, 0 = DIO1 */
> +	ADIS16209_MSC_CTRL_DATA_RDY_DIO2 = BIT(0),
> +};
>
>  /* DIAG_STAT */
>
> -/* Alarm 2 status: 1 = alarm active, 0 = alarm inactive */
> -#define ADIS16209_DIAG_STAT_ALARM2        BIT(9)
> +enum adis16209_diag_stat {
> +	/* Alarm 2 status: 1 = alarm active, 0 = alarm inactive */
> +	ADIS16209_DIAG_STAT_ALARM2 = BIT(9),
>
> -/* Alarm 1 status: 1 = alarm active, 0 = alarm inactive */
> -#define ADIS16209_DIAG_STAT_ALARM1        BIT(8)
> +	/* Alarm 1 status: 1 = alarm active, 0 = alarm inactive */
> +	ADIS16209_DIAG_STAT_ALARM1 = BIT(8),
>
> -/* Self-test diagnostic error flag: 1 = error condition, 0 = normal operation */
> -#define ADIS16209_DIAG_STAT_SELFTEST_FAIL_BIT	5
> +	/* Self-test diagnostic error flag:
> +	 * 1 = error condition, 0 = normal operation
> +	 */
> +	ADIS16209_DIAG_STAT_SELFTEST_FAIL_BIT = 5,
>
> -/* SPI communications failure */
> -#define ADIS16209_DIAG_STAT_SPI_FAIL_BIT	3
> +	/* SPI communications failure */
> +	ADIS16209_DIAG_STAT_SPI_FAIL_BIT = 3,
>
> -/* Flash update failure */
> -#define ADIS16209_DIAG_STAT_FLASH_UPT_BIT	2
> +	/* Flash update failure */
> +	ADIS16209_DIAG_STAT_FLASH_UPT_BIT = 2,
>
> -/* Power supply above 3.625 V */
> -#define ADIS16209_DIAG_STAT_POWER_HIGH_BIT	1
> +	/* Power supply above 3.625 V */
> +	ADIS16209_DIAG_STAT_POWER_HIGH_BIT = 1,
>
> -/* Power supply below 3.15 V */
> -#define ADIS16209_DIAG_STAT_POWER_LOW_BIT	0
> +	/* Power supply below 3.15 V */
> +	ADIS16209_DIAG_STAT_POWER_LOW_BIT = 0,
> +};
>
>  /* GLOB_CMD */
>
> -#define ADIS16209_GLOB_CMD_SW_RESET	BIT(7)
> -#define ADIS16209_GLOB_CMD_CLEAR_STAT	BIT(4)
> -#define ADIS16209_GLOB_CMD_FACTORY_CAL	BIT(1)
> -
> -#define ADIS16209_ERROR_ACTIVE          BIT(14)
> +enum adis16209_glob_cmd {
> +	ADIS16209_GLOB_CMD_SW_RESET = BIT(7),
> +	ADIS16209_GLOB_CMD_CLEAR_STAT = BIT(4),
> +	ADIS16209_GLOB_CMD_FACTORY_CAL = BIT(1),
> +};
>
> -#define ADIS16209_SCAN_SUPPLY	0
> -#define ADIS16209_SCAN_ACC_X	1
> -#define ADIS16209_SCAN_ACC_Y	2
> -#define ADIS16209_SCAN_AUX_ADC	3
> -#define ADIS16209_SCAN_TEMP	4
> -#define ADIS16209_SCAN_INCLI_X	5
> -#define ADIS16209_SCAN_INCLI_Y	6
> -#define ADIS16209_SCAN_ROT	7
> +enum adis16209_scan {
> +	ADIS16209_SCAN_SUPPLY,
> +	ADIS16209_SCAN_ACC_X,
> +	ADIS16209_SCAN_ACC_Y,
> +	ADIS16209_SCAN_AUX_ADC,
> +	ADIS16209_SCAN_TEMP,
> +	ADIS16209_SCAN_INCLI_X,
> +	ADIS16209_SCAN_INCLI_Y,
> +	ADIS16209_SCAN_ROT,
> +};
>
>  static const u8 adis16209_addresses[8][1] = {
>  	[ADIS16209_SCAN_SUPPLY] = { },
> --
> 1.9.1
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/1488715674-22836-1-git-send-email-narcisaanamaria12%40gmail.com.
> For more options, visit https://groups.google.com/d/optout.
>
