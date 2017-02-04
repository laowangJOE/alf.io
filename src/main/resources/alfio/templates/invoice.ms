<?xml version="1.0" encoding="UTF-8"?>
<html>
	<head>
		<style>
			body {
				font-family:"Helvetica Neue", Helvetica, Arial, sans-serif;
				font-size:11pt;
			}

            h1,h2,p {margin:0;}

			h2 {
				font-size:120%;
				font-weight:normal;
				margin-bottom:10px;
			}

			h3 {
			    font-weight:normal;
			}

			table {
				margin-bottom:30px;
			}

			.text-center {
			    text-align:center;
			}

			.text-right {
                text-align:right;
            }

            .margin-bottom-line {
                margin-bottom:1em;
            }

            table.summary {
                border-collapse:collapse;
                margin-bottom: 20px;
                border-spacing: 0;
            }

            table.summary > tbody > tr:nth-child(even) > td,
            table.summary > tbody > tr:nth-child(even) > th {
                background-color: #f9f9f9;
            }

            table.summary > tbody > tr:last-child > td {
                border-bottom: 1px solid #aaa;
            }

            table.summary, table.summary th, table.summary td {
                border: 1px solid #aaa;
                padding:5px;
                margin:0;
            }

            table.summary > tfoot,
            table.summary > tfoot > tr > th {
                border-color: #ffffff;
            }

            table.summary > tfoot > tr:first-child > th {
                border-top: 1px solid #aaa;
            }

            table.summary > thead > tr > th {
                background-color: #f9f9f9;
            }

            table.summary td, table.summary th {
                min-height: 25px;
            }

            .strong {
                font-weight: bold;
            }

            .mb {
                margin-bottom: 3em;
            }

            .no-padding {
                padding: 0 !important;
            }
            .small {
                font-size:80%;
            }

		</style>
	</head>
	<body>
        <table style="width:100%">
            <tr>
                {{#eventImage}}<td style="width:{{imageWidth}}px; height:{{imageHeight}}px"><img style="margin:auto; width:{{imageWidth}}px; height:{{imageHeight}}px" src="{{eventImage}}"/></td>{{/eventImage}}
                {{^eventImage}}<td style="text-align: center; vertical-align: middle;"><h1>{{event.displayName}}</h1></td>{{/eventImage}}
                <td style="text-align: center; vertical-align: middle;"><h1>{{#i18n}}invoice.vat-invoice{{/i18n}}</h1></td>
            </tr>
        </table>

        <hr>

        <table style="width:100%;" class="mb">
            <tr>
                <td colspan="2" style="text-align: left" class="small">
                    <p>{{invoiceAddress}}</p>
                    <p>{{#i18n}}invoice.vat{{/i18n}} {{vatNr}}</p>
                    <p class="strong">{{#i18n}}invoice.number{{/i18n}} {{ticketReservation.invoiceNumber}}</p>
                    <p>{{#i18n}}invoice.date{{/i18n}} {{#format-date}}{{confirmationDate}} dd MMM yyyy locale:{{#i18n}}locale{{/i18n}}{{/format-date}}</p>
                </td>
            </tr>
            <tr>
                <td style="width:60%">
                    &nbsp;
                </td>
                <td style="width:40%">
                    <p class="margin-bottom-line">{{#i18n}}invoice.to{{/i18n}}</p>
                    {{#ticketReservation.hasBillingAddress}}
                    {{#ticketReservation.lineSplittedBillingAddress}}
                    <p>{{.}}</p>
                    {{/ticketReservation.lineSplittedBillingAddress}}
                    {{/ticketReservation.hasBillingAddress}}
                </td>
            </tr>
        </table>


        <h3><span class="strong">{{event.displayName}}</span>,
            <i>
                {{#event.sameDay}}{{#i18n}}event-days.same-day [{{#format-date}}{{event.begin}} EEEE dd MMMM yyyy locale:{{#i18n}}locale{{/i18n}}{{/format-date}}] [{{#format-date}}{{event.begin}} HH:mm{{/format-date}}] [{{#format-date}}{{event.end}} HH:mm (z){{/format-date}}] {{/i18n}}{{/event.sameDay}}
                {{^event.sameDay}}{{#i18n}}event-days.not-same-day [{{#format-date}}{{event.begin}} EEEE dd MMMM yyyy locale:{{#i18n}}locale{{/i18n}}{{/format-date}}] [{{#format-date}}{{event.begin}} HH:mm{{/format-date}}]{{/i18n}} - {{#i18n}}event-days.not-same-day [{{#format-date}}{{event.end}} EEEE dd MMMM yyyy locale:{{#i18n}}locale{{/i18n}}{{/format-date}}] [{{#format-date}}{{event.end}} HH:mm (z){{/format-date}}]{{/i18n}} {{/event.sameDay}}
            </i>
        </h3>
        <table style="width:100%;" class="summary">
            <thead>
                <tr>
                    <th class="text-center" style="width:10%">{{#i18n}}reservation-page.amount{{/i18n}}</th>
                    <th class="text-center" style="width:60%">{{#i18n}}reservation-page.category{{/i18n}}</th>
                    <th class="text-center" style="width:15%">{{#i18n}}reservation-page.price{{/i18n}} ({{event.currency}})</th>
                    <th class="text-center" style="width:15%">{{#i18n}}reservation-page.subtotal{{/i18n}} ({{event.currency}})</th>
                </tr>
            </thead>
            <tbody>
        {{#orderSummary.summary}}
                <tr>
                    <td class="text-center">{{amount}}</td>
                    <td>{{name}}</td>
                    <td class="text-right">{{priceBeforeVat}}</td>
                    <td class="text-right">{{subTotalBeforeVat}}</td>
                </tr>
        {{/orderSummary.summary}}
            </tbody>
            <tfoot>
                {{^orderSummary.free}}
                <tr><th colspan="3" class="no-padding">{{#i18n}}reservation-page.vat [{{event.vat}}]{{/i18n}}</th><th class="text-right">{{orderSummary.totalVAT}}</th></tr>
                {{/orderSummary.free}}
                <tr><th colspan="3" class="strong" class="no-padding">{{#i18n}}reservation-page.total{{/i18n}}</th><th class="text-right strong">{{event.currency}} {{orderSummary.totalPrice}}</th></tr>
                {{^orderSummary.free}}
                {{/orderSummary.free}}
            </tfoot>
        </table>

        <div class="small mb" style="margin-top:1em">
            <p class="strong">{{#i18n}}invoice.order-information{{/i18n}}</p>
            <p>{{ticketReservation.id}}</p>
            <p>{{#i18n}}invoice.buyer{{/i18n}} {{ticketReservation.fullName}} &lt;{{ticketReservation.email}}&gt;</p>
        </div>

        <p>{{#i18n}}invoice.regards{{/i18n}}</p>
        <p>{{organization.name}}</p>

    </body>
</html>